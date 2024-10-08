# Data Wrangling
Data wrangling, also known as data munging, is the process of cleaning, transforming, and organizing raw data into a more usable format for analysis or reporting. This process is essential because raw data is often messy, incomplete, or unstructured, making it difficult to derive meaningful insights without proper preparation. Often times, we find ourselves handling complex data that needs to be incrementally broken down into different shapes and forms at different stages to finally come off as meaningful information. Data wrangling enables us to break down a complex data processing task into several subtasks, carry out those subtasks with off-the-shelf tools, and seamlessly integrate the subtasks into a final comprehensive piece of information. This tutorial will teach us command-line tools to facilitate data wrangling.

You can follow this tutorial using Linux or MacOS terminals. If you are on Windows, you can use WSL (Windows Sub-system for Linux) command line.

## PIPES

Pipes are a fundamental inter-process communication mechanism on operating systems. They enable the output of one process to be redirected to another. When you write a command on the terminal, the shell is actually creating a process that can execute your command. Since pipes are used to glue together different processes, you can also use pipes on the terminal to enable communication between different commands. The pipe command, represented as a bar symbol **|**, lets you transfer the output of one command as the input of the next. To understand pipes, first let's review some handy shell commands. Feel free to open your command line or terminal. Type in the following commands and observe the output:

1. **ls:** prints out the list of files and sub-directories in the present working directory
2. **ls -l:** prints out the list of files and sub-directories in the present working directory including detailed information related to the permissions, owner, size, dates etc. of each of the files.
3. **wc \<filename\>:** counts the lines, words, and characters in a file
4. **wc -l \<filename\>:** counts only the lines in a file

That's all fine and dandy. But, what if you want to count the number of files in the present working directory?

If you remember the definition of data wrangling, it can involve a handful of operations on a piece of data. These operations are typically done in a specific order - one after the other. So, one needs an organized and synchronous pipeline that takes as input the original piece of data and in stages transforms it into the desired piece of information. Now, we will look at how we can create a simple but powerful data pipeline in the shell environment using the pipe ( | ) command.

Type the following command and behold: `ls | wc -l`. We are now able to count the number of files in the current directory. Now we will try to understand how the pipe command works. But to understand that, we must remember that "In Unix (like systems), everything is a file". So, during the command "ls | wc -l", the shell takes the output of the command "ls" and passes that onto the command "wc -l" as input in the form of a file (remember that "wc" expects a file as an input).

Now let's try to understand some complex examples of the pipe command. In the given hw4.zip file, take a look inside the dataset1 directory and you will see 30 files. Each of these files contains some text. Suppose someone asks us to filter only the files containing the word “sample” and exactly 3 lines containing the word “CSC510”. We can execute the following command:  
```bash
grep -c "CSC510" file*| grep -E ":3$" | cut -d: -f1
```
Now, if we are asked to sort the names of these files in a descending order based on the size of the files, we can enhance the previous command as follows:
```bash
grep -c "CSC510" file*| grep -E ":3$" | cut -d: -f1 | xargs ls -l | sort -k5,5nr
```
Additionally, when printing the names of these filtered files, if we want to change the file name format from “file_#” to “the_file_#”, we can use the following command including “sed” for the substitution:  
```bash
grep -c "CSC510" file*| grep -E ":3$" | cut -d: -f1 | xargs ls -l | sort -k5,5nr | sed 's/file_/the_name_/'
```
Now, if we want to append “_filtered” at the end of each file name, we can execute the following command adding “gawk”:
```bash
grep -c "CSC510" file*| grep -E ":3$" | cut -d: -f1 | xargs ls -l | sort -k5,5nr | sed 's/file_/the_name_/' | gawk '{ print $9 "_filtered" }'
```
In this relatively complex example, we have seen the usage of multiple tools like `grep`, `cut`, `xargs`, `sort`, `sed`, and `gawk`. Let's take a moment to appreciate the immense power bestowed upon us through these tools especially when they are combined with pipes. This entire pipeline might seem enigmatic at this point. But, it will all make sense by the end of the tutorial.

Let's now try to unravel this enigma. The command `cut` extracts a specific column from a piece of data containing multiple columns separated by some field separator that is specified with the `d` flag. `xargs` takes a number of rows and runs the command that follows (in this case ls-l) on each of the rows one at a time. `sort` command sorts the list of given inputs based on some criteria (in this case, the options for sort are `k` which specifies the range of columns used for sorting, `n` which means numeric sort and `r` which means in reverse order i.e. descending order). Next, we will look at the `grep`, `sed`, and `gawk` commands in more detail.

## GREP

grep is a powerful command-line tool used for searching plain-text data sets for lines that match a regular expression. The name stands for Global Regular Expression Print. It's commonly used in Unix-based systems like Linux and macOS. Whether you’re searching for a specific string in a file, filtering output from other commands, or looking for patterns across multiple files, grep is the tool for the job.

***Basic Syntax: grep [options] pattern [file...]***

- ***pattern:*** The string or regular expression you want to search for.

- ***file:*** The file(s) where the search is performed. If no file is specified, grep searches the input from standard input (like output from another command). 

#### Common Options

-   `-i`: Ignore case distinctions in both the pattern and the input files.  
    Example: grep -i "hello" file.txt
-   `-r` or `-R`: Recursively search directories.  
    Example: grep -r "hello" /path/to/directory  
-   `-l`: Print only the names of files with matching lines.  
    Example: grep -l "hello" *.txt    
-   `-n`: Prefix each line of output with the line number within its file.  
    Example: grep -n "hello" file.txt    
-   `-v`: Invert the match, showing lines that do not match the pattern.  
    Example: grep -v "hello" file.txt    
-   `-c`: Print only a count of matching lines per file.  
    Example: grep -c "hello" file.txt
-   `-o`: Print only the matched parts of matching lines.  
    Example: grep -o "hello" file.txt
    
grep is extremely powerful when used with regular expressions. Regular expressions allow you to search for complex patterns. Let's go over a quick primer of regular expressions below:

### Quick Primer on Regular Expressions (Regex)

Regular expressions (regex) are sequences of characters that define search patterns, primarily used for string matching and manipulation. They are powerful tools for searching, replacing, and parsing text in many programming languages and tools like grep, sed,gawk, and editors like VSCode.

#### Basic Components of Regex

1.  **Literals**
-   These are the simplest regex elements. They match the exact characters they represent.
-   Example: cat matches "cat" in "catapult" or "scattered".
2.  **Metacharacters**
-   Metacharacters are special symbols that have specific meanings in regex.    
-   Common metacharacters: . ^ $ * + ? {} [] () \ |

#### Common Metacharacters and Their Uses

1.  **. (Dot)**
 -   Matches any single character except a newline.    
 -   Example: c.t matches "cat", "cut", "cot".
2.  **^ (Caret)**
 -   Matches the start of a string.   
 -   Example: ^The matches "The" only if it's at the beginning of a line.
3.  **$ (Dollar)**
-   Matches the end of a string.    
-   Example: end$ matches "end" only if it's at the end of a line.
4.  **\* (Asterisk)**
-   Matches 0 or more occurrences of the preceding element.    
-   Example: ca*t matches "ct", "cat", "caaaat".
5.  **+ (Plus)**
-   Matches 1 or more occurrences of the preceding element.  
-   Example: ca+t matches "cat", "caaaat", but not "ct".
6.  **? (Question Mark)**
-   Matches 0 or 1 occurrence of the preceding element.    
-   Example: colou?r matches both "color" and "colour".
7.  **{} (Braces)**
-   Matches a specific number of occurrences of the preceding element.    
-   Example: a{3} matches "aaa".
-   {min,}: At least min occurrences.
-   {min,max}: Between min and max occurrences.
8.  **[] (Square Brackets)**
-   Matches any one of the characters inside the brackets.
-   Example: [aeiou] matches any vowel.
-   [0-9] matches any digit.
9.  **() (Parentheses)**
-   Groups parts of a regex together and captures the matched text.    
-   Example: (ab)+ matches "ab", "abab", "ababab".
10. **| (Pipe)**
-   Acts as a logical OR between patterns.    
-   Example: cat|dog matches either "cat" or "dog".
11. **\ (Backslash)**
-   Escapes a metacharacter to treat it as a literal.    
-   Example: \. matches a literal dot instead of any character.

#### Character Classes

-   `\d`: Matches any digit (equivalent to [0-9]).
-   `\D`: Matches any non-digit.
-   `\w`: Matches any word character (alphanumeric + underscore).
-   `\W`: Matches any non-word character.
-   `\s`: Matches any whitespace character (space, tab, newline).
-   `\S`: Matches any non-whitespace character.
    
#### Anchors

-   ^: As mentioned earlier, it matches the start of a string.
-   $: Matches the end of a string.
    
We will be using the -E flag with grep when we want to match regular expression patterns since the -E flag enables extended regular expressions to facilitate advanced patterns like alternation, repetition, and optional items. Some examples of using regular expression search patterns with grep are as follows:

1.  Find lines that start with "Error": grep -E "^Error" logfile.txt    
2.  Find lines that end with a digit: grep -E "[0-9]$" data.txt
3.  Find lines that contain either "cat" or "dog": grep -E "cat|dog" animals.txt
4.  Find lines where "error" appears exactly three times: grep -E "(error.*){3}" logfile.txt
5.  Find lines with a date in YYYY-MM-DD format: grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}" file.txt
6.  Find lines with an email address: grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" file.txt
7.  Find lines that do not contain the word "success": grep -E -v "success" logfile.txt
8.  Find lines with at least one whitespace character: grep -E "\s" file.txt
9.  Find lines where the word "fail" is followed by a number: grep -E "fail[0-9]" file.txt
10.  Find lines with a 5-digit zip code: grep -E "\b[0-9]{5}\b" addresses.txt
    
## SED

SED, short for Stream EDitor, is a powerful text-processing utility found in Unix and Unix-like operating systems. It is used to perform basic text transformations on an input stream (a file or input from a pipeline). SED operates by reading the input line by line, applying specified editing commands, and then outputting the modified text. It's widely used for tasks like searching, find-and-replace operations, text deletion, and insertion.

This tutorial will introduce you to the basics of SED, covering simple operations and more advanced features.

***Basic Syntax: sed 'command' input_file***

-   ***command:*** This is where you specify what operation SED should perform, such as substitution or deletion.

-   ***input_file:*** The file you want SED to process. If you omit the file, SED will read from the standard input (such as the terminal or another command's output).
    

### Common SED Commands

#### Substitution Command
The substitution command (s) is one of the most commonly used SED commands. It replaces specified text within a line.
***Example:*** To replace "apple" with "orange" in a file:
```bash
sed 's/apple/orange/' input_file
```
This command replaces the first occurrence of "apple" with "orange" in each line of the file.

#### Global Substitution
By default, SED replaces only the first occurrence of the pattern in each line. To replace all occurrences in a line, use the g flag:
***Example:*** To replace all occurrences of "apple" with "orange" in each line:
```bash
sed 's/apple/orange/g' input_file
```

#### Deleting Lines
The delete command (d) removes entire lines that match a given pattern.
***Example:*** To delete all lines containing the word "delete_me":
```bash
sed '/delete_me/d' input_file
```
This removes any line in the file that contains "delete_me".

#### Deleting Specific Text
If you only want to delete specific text within a line without removing the entire line, you can use the substitution command with an empty replacement string.
***Example:*** To remove the word "delete_me" from a line:
```bash
sed 's/delete_me//' input_file
```
This removes "delete_me" wherever it appears in a line, but leaves the rest of the line intact.

### Advanced Features
#### Addressing
You can specify which lines to apply your SED commands to by using line numbers or patterns.
***Single Line:*** To apply a command to a specific line, you can use its line number. For example, to replace "foo" with "bar" only on line 3:
```bash  
sed '3s/foo/bar/' input_file
```
***Range of Lines:*** To apply a command to a range of lines, use the format start_line, and end_line. For example, to delete lines 3 through 5:
```bash
sed '3,5d' input_file
```
***Pattern Matching:*** You can also use patterns to match lines. For example, to replace "foo" with "bar" only on lines containing "baz":
```bash
sed '/baz/s/foo/bar/' input_file
```
***Using Multiple Commands:*** You can chain multiple commands together by separating them with a semicolon or by using the -e option. For example, to replace "foo" with "bar" and then delete lines containing "delete_me":
```bash
sed 's/foo/bar/; /delete_me/d' input_file
```
Alternatively:
```bash
sed -e 's/foo/bar/' -e '/delete_me/d' input_file
```
***Writing to a New File:*** To save the output to a new file instead of displaying it on the screen, redirect the output:
```bash
sed 's/foo/bar/' input_file > output_file
```
-   Exercise: To replace the third occurrence of "foo" in each line with "bar":  
    sed 's/foo/bar/3' input_file
    
-   Exercise: To replace "foo" with "bar" only on lines from 10 to 20:  
    sed '10,20s/foo/bar/' input_file
    

## GAWK

GAWK is GNU Project's version of AWK. The AWK programming language was originally created in the 1970s as a powerful text-processing language used in Unix and Unix-like operating systems. GAWK is designed for pattern scanning and processing. It allows you to extract information, perform calculations, and generate formatted reports, making it an essential tool for data analysis and text manipulation.

This tutorial will cover the basics of GAWK, including how to use it for simple tasks like text extraction, as well as more advanced features like working with fields, patterns, and GAWK scripts. If you don't have gawk installed, you should be able to easily install it using your operating system's package manager (e.g. apt or brew).

***Basic Syntax: gawk 'pattern { action }' input_file***

-   ***pattern:*** The condition that GAWK tests for each line. If the pattern is true, GAWK executes the associated action.

-   ***action:*** The command(s) GAWK runs when the pattern is matched. If no action is specified, GAWK prints the entire line.

-   ***input_file:*** The file that GAWK processes. If omitted, GAWK reads from standard input.

### Working with Fields

GAWK automatically splits each line of input into fields based on a delimiter (by default, whitespace). Each field is represented by $1, $2, etc., where $1 is the first field, $2 is the second, and so on. $0 represents the entire line.

#### Extracting Specific Fields

To print specific fields from a file:
```bash
gawk '{ print $1, $3 }' input_file
```
This command prints the first and third fields from each line of the file.

#### Changing the Field Separator

If your data is separated by something other than whitespace, you can change the field separator using the -F option.

For example, if your fields are separated by commas:
```bash
gawk -F, '{ print $1, $2 }' input_file
```
This prints the first and second fields from a comma-separated file.

### Using Patterns

GAWK allows you to specify patterns that determine which lines are processed.

#### Simple Pattern Matching
To print lines that match a specific pattern:
```bash
gawk '/pattern/ { print $0 }' input_file
```
This command prints all lines containing the word "pattern".

#### Matching with Conditions
You can also use conditions to match patterns. For example, to print lines where the value in the third field is greater than 100:
```bash
gawk '$3 > 100 { print $0 }' input_file
```
This command prints any line where the third field is greater than 100.

### Performing Calculations

GAWK can perform arithmetic operations on fields, which is particularly useful for data analysis.

#### Simple Arithmetic

To calculate the sum of the values in the second and third fields:
```bash
gawk '{ print $2 + $3 }' input_file
```
This prints the sum of the second and third fields for each line.

#### Aggregating Data
To calculate the total sum of a particular field across all lines:
```bash
gawk '{ sum += $2 } END { print sum }' input_file
```
This sums the values in the second field across all lines and prints the result at the end.

### Using Built-in Variables

GAWK provides several built-in variables that are useful for more complex tasks:

-   NR: The current record (line) number.
-   NF: The number of fields in the current record.
-   FS: The input field separator.
-   OFS: The output field separator.
 
Example: To print the line number followed by the last field on each line:
```bash
gawk '{ print NR, $NF }' input_file
```

### Writing GAWK Scripts

For more complex tasks, you can write a GAWK script and store it in a file. A GAWK script file typically looks like this:
```bash
BEGIN { FS = ","; OFS = "\t" } {
	if ($3 > 100)
	print $1, $3 * 2
}
END { print "Processing Complete" }
```
You can run the script with:
```bash
gawk -f script.gawk input_file
```
This script sets the field separator to a comma and the output field separator to a tab. It then prints the first field and doubles the value of the third field for lines where the third field is greater than 100. Finally, it prints "Processing Complete" after processing the entire file.

## And, finally ...

You've probably been wondering: ***when to use grep, sed, and gawk?*** Typically, try to use **grep** for searching, **sed** for substitutions, and **gawk** for more complex tasks. The renowned computer scientist [Douglas Mcilroy](https://en.wikipedia.org/wiki/Douglas_McIlroy) who coined the concept of pipelines, recommended the following: ***don't use sed when you can use grep and don't use (g)awk when you can use sed***.

In this tutorial, we learnt about various useful shell commands to facilitate data wrangling. We have seen complex example tasks that had to be broken down into smaller subtasks thus teaching us an important organizational lesson of task decomposition. Decomposing a complex task into smaller subtasks makes debugging and team-work much more convenient since different team members can work on different parts of the pipeline and can eventually integrate their individual parts to form the whole.

## Homework

1. Download and unzip [hw4.zip](https://moodle-courses2425.wolfware.ncsu.edu/mod/resource/view.php?id=547767).

2. Inside the hw4.zip, you will find a bash script called `infinite.sh`. Run the script using `bash infinite.sh`. The script will now run infinitely in the background. Your task is to write a simple script task1.sh to kill this process.

3. Recall the example where we counted and modified the names of the files containing the word "sample" and exactly 3 lines containing the word "CSC510" in each file of dataset1. Now, we are challenged to do a similar task but with slightly different specifications.
    a. First list the files containing the word "sample" and at least 3 occurrences of the word "CSC510". Note that we are no longer talking about lines containing the word "CSC510" but instead the actual number of times the word "CSC510" occurs. You are **not allowed to use `gawk` for this task** but instead use a combination of `grep` and `uniq` (note: if you are unfamiliar with `uniq`, on a terminal write `man uniq` and you will get the user manual for the command `uniq`).
	b. Sort in descending order the list of the filtered files based on the occurrences of the word "CSC510". You have to break the ties by the size of the files. You will **have to** use `gawk` along with the other commands for this task.
	c. Finally, from each file name substitute "file_" with "filtered_" and list the final output.
	
	Build a single pipeline of commands for all the tasks a, b, and c and store the pipeline inside a script called task2.sh.

4. Take a look at titanic.csv which is a dataset containing passenger details and their survival during the Titanic disaster. We want you to analyze this dataset from the shell using the tools that you have learnt in this tutorial.
    a. Extract passengers from 2nd class who embarked at Southampton.
    b. Then replace male/female labels with respectively M/F.
    c. Finally, calculate the average age of the filtered passengers.

    Build a single pipeline of commands for all the tasks a, b, and c and store the pipeline inside a script called task3.sh.

5. Push task1.sh, task2.sh, and task3.sh files to your HW4 GitHub repository with the same badges as those from HW1.

6. Submit a PDF report containing the following information:
    a. Group number
    b. Names of the group members
    c. GitHub link of your HW4 repository
    d. Output of task1.sh, task2.sh, and task3.sh

## Important Links
1. [GREP examples](https://alvinalexander.com/unix/edu/examples/grep.shtml)
2. [SED examples](https://learnxinyminutes.com/docs/sed/)
3. [AWK examples](https://learnxinyminutes.com/docs/awk/)
4. [Debugging pipes with **tee**](https://www.geeksforgeeks.org/tee-command-linux-example/)
5. [Debugging regular expressions](https://regex101.com/)
6. [MIT missing semester](https://missing.csail.mit.edu/2020/data-wrangling/)