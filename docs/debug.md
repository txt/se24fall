% Debugging 

## Debugging

**Debugging:** The process by which a programmer detects, and reproduces a software fault. 

Please download the files debugging.py for use in the following sections. Most of this debugging tutorial will be done using UNIX commands. If you are on a windows machine, please install Windows Subsystem for Linux (WSL) and use that to execute the commands in the walkthrough. 

### Debugging using print statements, logging

debugging.py is supposed to perform selection sort on an array of integers, passed into the function as the variable arr.   

```
def selectionSort(arr):  
   n = len(arr)  
   for i in range(n):  
       lowestIndex = i  
       for j in range(n):  
           if arr[j] < arr[lowestIndex]:  
               lowestIndex \= j

       arr[lowestIndex] = arr[i]  
       arr[i] = arr[lowestIndex]  
       n = n - 1

   return arr

arr_in = [5, 3, 2, 1, 8, 10, 11, 9, 23]

arr_out = selectionSort(arr_in)

print(arr_out)
```

If you’ve finished Homework 1, you should have python3.13 installed. To run debugging.py,   
copy it to a work\_dir folder, and run the following command in your command line:
```  
~/work_dir$ chmod u+x debugging.py  
~/work_dir$ python3.13 debugging.py  
[23, 11, 8, 5, 8, 10, 11, 9, 23]
```

Unfortunately, our selection sort has a bug in it, as the array the program output is not in sorted order. How could we go about finding our bug?

**Print debugging**  
The first and easiest solution most of us think of is to print out the state of the array after every operation that affects the array. With enough print statements, we’ll be able to pinpoint at what point in the algorithm something unexpected occurs. Let’s augment our previous version of debugging.py to include print statements.

```
def selectionSort(arr):
   n = len(arr)
   for i in range(n):
       lowestIndex = i
       for j in range(n):
           if arr[j] < arr[lowestIndex]:
               lowestIndex = j


       print("lowest index ", lowestIndex) # what index contains the lowest value?
       print("i ", i) # where in the array should the ith smallest value be?
       print("n ", n) # where are we considering the end of the array?


       print("before ", arr) # what is array state before we swap anything?
       arr[lowestIndex] = arr[i]
       print("first ", arr) # what is array state after the first write?
       arr[i] = arr[lowestIndex]
       print("final", arr) # what is array state after the second write?
       n = n - 1


   return arr
```

Adding print statements to the code serves as a good exercise of whether you understand the code you’ve written. My methodology for adding print statements is as follows:

1. Print any variable that changes  
   1. lowestIndex, i, n  
2. Print data structures before changes, and after changes  
   1. Arr  
3. Comment all of your print statements to explain what each value / change represents

In this example, we do not need to print j, as it is captured in lowestIndex, and only used to determine lowestIndex.  

Upon executing our new debugging.py, you’ll immediately notice that the output was much longer than before, probably causing your shell window to scroll downwards. While print debugging can be useful, working with the artifacts of it, specifically text on the command line, can be difficult, and is prone to accidental loss. If we wanted to save our print statements to a file for ease of use, we can use the python logging library. 

The important difference between printing to stdout / stderr, and using a logger to write to a log file, is that in many of the services you’ll be deploying in this course, prints to stdout / stderr are not captured in any way. When you print to a log file, you can either have another service that consumes your logs and sends them to a centralized database (ex. ElasticSearch), or you can remote directly into the server that is hosting your service, and download the log files from the server. Let’s examine our debugging.py, but with all of the print statements rewritten to use python’s logging library.

```
import logging, sys
logging.basicConfig(filename='debugging.log', encoding='utf-8', level=logging.DEBUG, format='%(asctime)s %(message)s')
logging.debug("NEW LOG")


def selectionSort(arr):
   logger = logging.getLogger(__name__)
   n = len(arr)
   for i in range(n):
       lowestIndex = i
       for j in range(n):
           if arr[j] < arr[lowestIndex]:
               lowestIndex = j


       logger.debug("lowest index: %r", lowestIndex) # index w/ lowest value
       logger.debug("i: %r", i) # ith smallest index
       logger.debug("n: %r", n) # end of array


       logger.debug("before: %r", arr) # array state before we swap anything?
       arr[lowestIndex] = arr[i]
       logger.debug("first: %r", arr) # state after the first change?
       arr[i] = arr[lowestIndex]


       logger.debug("final: %r", arr) # array state after the second change?
       n = n - 1


   return arr
```

The update to use loggers was relatively simple; the print statements have been replaced with calls to logger.debug, and the basic logging configuration needed to be set up. For our logger, I’ve set it to output to debugging.log, encoded the output in utf-8, and changed the output format to prepend the ascii time to all messages. Let’s re-run our code and examine the output. Since we are working with log files and not command line output, it is easy to leave comments on the file to help facilitate your understanding of the log. 
```
~/work_dir$ python3.13 debugging.py
~/work_dir$ cat debugging.py


2024-08-27 11:34:14,335 NEW LOG
lowest index  3
i  0
n  9
before  [5, 3, 2, 1, 8, 10, 11, 9, 23]
first  [5, 3, 2, 5, 8, 10, 11, 9, 23] ### 5 is swapped from index 0 into index 3
final [5, 3, 2, 5, 8, 10, 11, 9, 23]  ### 5 is swapped from index 3 into index 0
lowest index  2
i  1
n  8 ### why are not considering the last element (23) of the array?
before  [5, 3, 2, 5, 8, 10, 11, 9, 23]
first  [5, 3, 3, 5, 8, 10, 11, 9, 23] ### 3 is swapped from index 2 into index 1
final [5, 3, 3, 5, 8, 10, 11, 9, 23]  ### 3 is swapped from index 1 into index 2
```

As the inline comments call out, the first operation that edits the array, arr\[lowestIndex\] \= arr\[i\], is causing the element in arr\[lowestIndex\] to be overwritten by the element in arr\[i\]. This can be easily fixed by saving arr\[lowestIndex\] into a temporary variable, and then writing that temporary variable into arr\[i\]. Let’s update the code to use a temporary variable, then re-examine our output.

```
import logging, sys
logging.basicConfig(filename='partial_debugging.log', encoding='utf-8', level=logging.DEBUG, format='%(asctime)s %(message)s')
logging.debug("NEW LOG")


def selectionSort(arr):
   logger = logging.getLogger(__name__)
   n = len(arr)
   for i in range(n):
       lowestIndex = i
       for j in range(n):
           if arr[j] < arr[lowestIndex]:
               lowestIndex = j


       logger.debug("lowest index: %r", lowestIndex) # what index contains the lowest value?
       logger.debug("i: %r", i) # where in the array should the ith smallest value be?
       logger.debug("n: %r", n) # where are we considering the end of the array?


       lowestNum = arr[lowestIndex]


       logger.debug("lowestNum: %r",lowestNum) # lowest number found in unsorted array


       logger.debug("before: %r", arr) # array state before we swap anything
       arr[lowestIndex] = arr[i]
       logger.debug("first: %r", arr) # array state after the first change
       arr[i] = lowestNum


       logger.debug("final: %r", arr) # array state after the second change
       n = n - 1


   return arr

```

```
\~/work\_dir$ python3.13 debugging.py  
\[23, 10, 5, 8, 1, 2, 3, 9, 11\]
```


Unfortunately, even though we fixed a bug, our program actually had multiple bugs\! And while this process of adding logging to our file has been useful to record unexpected behavior for later examination, it has reduced the readability of the algorithm, and required editing our code and re-executing it after every change. As shown by this exercise, logging is best added AS YOU WRITE THE CODE, and not after the fact. Logging is best used to capture specific, important lines of output from your code that you can use for diagnosing and solving bugs in your code AFTER they have happened. 

What we really want to find our final bug in debugging.py is the ability to step through our code line by line, and inspect the contents of all of the variables and arrays as the unexpected behavior occurs. Python provides **PDB**, a debugger for the python programming language that is included in your installation of python3.13. Let’s cover how we can use **PDB** to find our bug more efficiently than using print statements and inspecting logs.

### Debugging with PDB

**Debugger:** A program that allows you to interact with the execution of a program. Most if not all programming languages come with a debugger. Debuggers typically provide the following ways of interacting with a program: 

* Placing **breakpoints** to halt execution of the program when it reaches a certain line  
* Stepping through the program one instruction at a time  
* Inspecting values of variables during execution and after the program has crashed  
* Conditionally halt the execution of the program when a given condition is met.

**PDB:** Debugger for the Python programming language. Included in python.  
To use **PDB** in debugging.py, import pdb, and add a call to breakpoint() on the line of code you’d like the debugger to stop execution on:

```import pdb
def selectionSort(arr):
   n = len(arr)
   for i in range(n):
       lowestIndex = i
       for j in range(n):
           if arr[j] < arr[lowestIndex]:
               lowestIndex = j


       breakpoint()
       lowestNum = arr[lowestIndex]
       arr[lowestIndex] = arr[i]
       arr[i] = lowestNum


       n = n - 1


   return arr```

Now when you execute debugging.py, you’ll be prompted with the pdb debugger, indicated by the (pdb) on your command line. To display code 11 lines above and below the breakpoint, enter l (l as in list).  
```~/work_dir$ python3.13 debugging.py
> /home/ubuntu/Home/PHD/tacsc510/pdb_partial_debugging.py(11)selectionSort()
-> breakpoint()
(Pdb) l
  6  	        lowestIndex = i
  7  	        for j in range(n):
  8  	            if arr[j] < arr[lowestIndex]:
  9  	                lowestIndex = j
 10  	
 11  ->	        breakpoint()
 12  	        lowestNum = arr[lowestIndex]
 13  	        arr[lowestIndex] = arr[i]
 14  	        arr[i] = lowestNum
 15  	
 16  	        n = n - 1```

Now we have loaded our program into PDB and stopped its execution, we have many options in interacting with our stalled program. Here are the main commands you should know:

* **l**(ist): Displays 11 lines around the current line or continue the previous listing  
* **s**(tep): Execute the current line, stop at the first possible location  
* **n**(ext): Continue execution until the next line in the current function is reached or it returns  
* **b**(reak): set a breakpoint  
* **p**(rint): Evaluate the expression in the current context and print its value 
* **d**(isplay): Same as print, but prints whenever the expression evaluates to a new value  
* **r**(eturn): Continue execution until the current function returns  
* **q(**uit) \- Quit the debugger 

Below is an attached video of using pdb to step through debugging.py and find the remaining bug:

[PDB Usage](https://www.youtube.com/PDB_VIDEO_NOT_HERE_YET)

## Static Analysis

**Static Analysis:** the process of evaluating a system or component based on its form, structure, content or documentation. Does **NOT** involve the execution of the program. Searches through code to detect bug patterns and security vulnerabilities. 

**Why do we statically analyze our code?** To find faults in our programs without executing the code. Code inspection can identify where code may not meet specifications or where  recommended programming practices are being broken. Well tested code written by experts often has a surprising number of obvious bugs that can be found via automated static analysis, without wasting time and money on a test deployment. \[2\] Static analysis tools serve an important role in cataloging and raising awareness of developers about subtle correctness issues that lead to future bug prevention. \[2\]

For debugging.py, the truth of the matter is that both bugs could be found via static analysis tools, without ever needing to run our code. Let’s review a few of the most useful static analysis tools for python:

* [pyflakes](https://pypi.org/project/pyflakes): Checks a python source file for errors that would cause the program to fail during execution  
* [pyright](https://github.com/Microsoft/pyright): Static type checker for python  
* [pylint](https://pylint.readthedocs.io/en/latest/): Looks for programming errors, helps enforce a coding standard, finds code smells, which are indications of deeper problems in a system  
* [Autopep8](https://pypi.org/project/autopep8/) \- Automatically formats python code to conform to the PEP 8 style guide.  
* [Bandit](https://bandit.readthedocs.io/en/latest/) \- Finds common security issues in python code 
* [Radon](https://radon.readthedocs.io/en/latest) \- Calculates metrics like cyclomatic complexity, maintainability index from your source code

and many more you can find at [analysis-tools.dev](https://github.com/analysis-tools-dev/static-analysis?tab=readme-ov-file)

## Software Testing

**Testing:** The process of finding software faults via **dynamic verification** of the behavior of a program, on a finite set of test cases, suitably selected, against the expected behavior. Involves the execution of the program.

**Fault:** as an incorrect step, process, or data definition in a program.

**Why do we test?** Without testing, you don’t know if your program actually behaves as expected. Before writing dedicated test cases, you may have only passed a tiny amount of inputs through your system, and only seen a tiny amount of outputs. Testing is the process of selecting good representative inputs for all possible interactions in your program and seeing whether they map to the expected output . Good tests provide a lens into how the program is working, and allow you to find software faults when they fail unexpectedly.

**Test Case:** Defines an individual test against a software system. Defines an input to the system and the expected output. Can be done at a high level against the entire software system, or at a low level against code units like methods classes. 

**White-box testing:** Writing tests with full understanding of the code. Tests are focused on exercising all code paths; logical decisions as both true and false, loops at their boundaries, and context-dependent testing of internal data structures.

**Black-box testing:** Writing tests while ignoring the internals of the program. Tests are focused on whether inputs produce expected outputs dictated by customer requirements.

**Unit Testing:** Testing of individual hardware or software units or groups of related units. Test cases consist of individual methods, interleaved methods, or classes. Done by programmers as white-box testing. Automation of unit testing is desired for consistency and ease of repeatability. 

**System Testing:** Testing conducted on a complete, integrated system to evaluate the system compliance with its specified requirements. Test cases are generated from analyzing customer requirements, and can be written before the system has even begun development. As system testing is black box, testing is often done by an external test group and not the programmers, as too much knowledge of the code can result in a lack of breadth in test cases. 

**Verification:** Are we building the product right? Done via white-box testing  
**Validation:** Are we building the right product? Done via black-box testing

**Code Coverage:** A measure of test case completeness.

* **Method Coverage:** Have all methods been called?  
* **Statement Coverage:** Have all the statements in a method been executed?  
* **Decision/Branch Coverage:** Have all decisions been executed in both the true and false paths?  
* **Condition Coverage:** Have all conditionals been executed in both the true and false paths?  
    
  **Limitation of Code Coverage:** The assumption that you are done testing if you have high coverage is incorrect. Coverage only tells you if you’ve covered the code that’s been written. There may be requirements you have missed while writing your code, which cannot be discovered via code coverage. \[1\]  
    
  **Test-driven Design:** Writing your test cases **BEFORE** you write the code that the case will test. 

## Homework 2 Assignment
1. Download and unzip hw2.zip
1. Execute AutoPep8 and **two** of the static analysis tools mentioned earlier on all files in hw2.zip
   1. Hw2\_debugging.py consists of an implementation of mergeSort that uses multiple helper methods in rand.py to sort the array that is currently failing 
      1. Make all of the code changes the static analysis tools recommend.  
      2. Re-run each tool, save the trace created by the tool in a folder called ‘post\_traces’  
      3. Fix the code, and commit your fixed version of hw2_debugging.py to your HW1 repository. 
   2. Write 3 test cases to verify your merge sort works, that are executable via pytest.  
   3. Configure autopep8, and the two static analysis tools you've used to run on your HW1 repo every commit. Add badges for each of the static analysis tools.
   4. Configure your new merge_sort test to run on the HW1 repo every commit, to ensure no regression can occur without a test failing. 



## Important Links:  
[https://docs.python.org/3/library/pdb.html](https://docs.python.org/3/library/pdb.html)   
[https://missing.csail.mit.edu/2020/debugging-profiling/](https://missing.csail.mit.edu/2020/debugging-profiling/)   

## References:  
Brian Marick, “How to Misuse Code Coverage,” [http://www.exampler.com/testingcom/writings/coverage.pdf](http://www.exampler.com/testingcom/writings/coverage.pdf) \[1\] 

Ayewah, Pugh, Hovemeyer, Morgenthaler, Penix, “Using Static Analysis to Find Bugs,” IEEE Software, vol. 25, no. 5, 2008\. \[2\] 
