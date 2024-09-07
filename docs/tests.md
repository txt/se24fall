% Testing

# Concepts to know

- V-diagram unit/system testong

## Quotes


- f u cn rd ths, u cn gt a gd jb n sftwr tstng.<br>
  - Anonymous
- "Program testing can be a very effective way to show the presence of bugs, but is hopelessly inadequate for showing their absence."<br>
  -  Edsger Dijkstra
- If debugging is the process of removing bugs, then programming must be the process of putting them in.<br>
  - Edsger Dijkstra
- Beware of bugs in the above code; I have only proved it correct, not tried it.<br>
  - Donald Knuth
- ... it is a fundamental principle of testing that you must know in advance the answer
   each test case is supposed to produce. If you don't, you are not testing; you are experimenting."<br>
  - Kernighan and Plauger
- Debugging is like a mystery novel where you are both the
  detective and the murderer.
  - Anon

## V-Diagram

- V-diagram
  - "Without requirements or design, programming is the art of adding bugs to an empty text file."
    -- Louis Srygley
  - Brooks, [Mythical Man Month](https://web.eecs.umich.edu/~weimerw/2018-481/readings/mythical-man-month.pdf).
    Effort is
    - 1/3 th planning
    - 1/6 th coding
    - 1/4 th unit testing : testing your own code
    - 1/4 th systems testing : testing your code, combined with others
      - may include:
        - Integration testing: verify the interfaces between components against a software design.
        - Acceptance testing:
          - User acceptance testing
          - Contractual and regulatory acceptance testing 
        - Alpha and beta testing
          - Alpha testing is simulated or actual operational testing by potential users/customer
          - Following alpha testing: external testing with a larger audience
             - Released to a limited audience outside of the programming team


**Testing:** The process of finding software faults via **dynamic verification** of the behavior of a program, on a finite set of test cases, suitably selected, against the expected behavior. Involves the execution of the program.

**Fault:** as an incorrect step, process, or data definition in a program.

- different to **failure** (when something actually goes wrongs)
- a program may have many faults, but never fail

**Why do we test?**

- Without testing, you don’t know if your program actually behaves as expected. Before writing dedicated test cases, you may have only passed a tiny amount of inputs through your system, and only seen a tiny amount of outputs. Testing is the process of selecting good representative inputs for all possible interactions in your program and seeing whether they map to the expected output . Good tests provide a lens into how the program is working, and allow you to find software faults when they fail unexpectedly.
-  Because there is so much to test for
  - Conformance to the requirements
    - But whose' requirements?
      - Welcome to the wonder of multi-stakeholder systems
    - Even if we try to make it complete,complete for who
      - Stakeholders, competing goals
      - Toronto CS department. Information system
        - "good" if parents can track their children
        - "good" if students  can maintain their privacy

  - For "maintainability?"
    - how to test that, except to watch the code for years to come?
  - Performance:
    - Energy usage
    - Network request response time?
    - Minimize variance in query spike time
  - Documentation :
    - Incomplete, always
  - For "usability"?
    - For other "ilities" (Maintainability, Customizanility,
    Scalability, Capacity, Availability, Reliability, Recoverability, Maintainability, Serviceability, Security, Regulatory, Manageability, Environmental, Data Integrity, Usability,
    Interoperability
  - And the list goes one and on and on

<img src="https://khalilstemmler.com/img/blog/object-oriented/analysis/non-functional-requirements/non-functional-requirements-map.png">

**Test-drive development**

- write tests first (which will instantly fail, since there is no code yet)
- Then, write code to fix the  failing tests
- At the end of each day
  - Leave something broken
  - So you can "switch in" straight away, tomorrow morning
- The TDD mantra
  - red (write failing tests)
  - green (write the code that fixes the tests)
  - refactor (sometimes, do a global clean up).
- Karac + Turhan (2018): TDD can't really be  defined or shown to be effective
  - [What Do We (Really) Know about Test-Driven Development? ](https://www.researchgate.net/profile/Itir_Karac/publication/326239274_What_Do_We_Really_Know_about_Test-Driven_Development/links/5cee7550299bf1f881494cf6/What-Do-We-Really-Know-about-Test-Driven-Development.pdf)
     - Itir Karac and Burak Turhan
  - TDD has too many cogs,
  - Its effectiveness is highly influenced by the context (for example, the tasks at hand or skills of individuals),
  - Hard to say when you are/are not doing TDD
      -  TDD isn’t a dichotomy in which you either religiously write tests first every time or always test after the fact.
      -  Studies of 416 developers over more than 24,000 hours
         -  only 12 percent of the projects that claimed to use it, actually did
                    "write test first"
         - Studies of all Java projects in Github:  only 0.8 % were TDD. And in that set, no evidence for
                 - no evidence for higher commit velocity or more issues reported or retired
  - Maybe TDD's "success" was just  that it happened at the same time that everyone stopped doing "C" and started using more
    interactive incremental development tools (e.g. Pyhton)

**Handling Large Test Suites**: can't retest everything

- some input clusters relate to new functionality
 the Elbaum heuristic from Elbaum, Sebastian, Gregg Rothermel, and John Penix. "Techniques for improving regression testing in continuous integration development environments." Proceedings of the 22nd ACM SIGSOFT International Symposium on Foundations of Software Engineering. 2014.
 - failed recently, last tested a while ago, or is new.
 - for very large test suites catches 50% of failures, within one hour
 - for a survey of other ordering heuristics, see  Ling, Xiao, Rishabh Agrawal, and Tim Menzies. "How different is test case prioritization for open and closed source projects?." IEEE Transactions on Software Engineering 48.7 (2021): 2526-2540.
   - warning: good test case orderings are different for open source projects  and in-house projects.


**Test Case:** Defines an individual test against a software system. Defines an input to the system and the expected output. Can be done at a high level against the entire software system, or at a low level against code units like methods classes. 

## Black-box testing 
- also known as _functional testing_
- Writing tests while ignoring the internals of the program. Tests are focused on whether inputs produce expected outputs dictated by customer requirements.
- assumes no internal knowledge of the code
- e.g. throw random input the code, looking for a core dump
- smarter way:
  - use domain knowledge. Metamorphic testing
### Metamorphic testing


How to test with an oracle for the specifics of the domain?


Metamorphic relations (MRs) are _necessary properties_ of the intended functionality of the software
- high-level statements that should be true across all inputs
- e.g. conjunctions do not lead to more output
   - RESULT1= "all males"
   - RESULT2="bald males"
   - RESULT2 should not be larger than RESULT1


- e.g. When testing a booking website, a web search for RESULT1= accommodation in Sydney, Australia, returns 1,671 results
    - RESULT2= Filter the price range or star rating and apply the search again;
    - RESULT2 should be a subset of RESULT1


A wonderful metamorphic testing result:  Z. Q. Zhou, T. H. Tse and M. Witheridge,
[Metamorphic Robustness Testing: Exposing Hidden Defects in Citation Statistics and Journal Impact Factors](https://www.cs.hku.hk/data/techreps/document/TR-2019-03.pdf) in IEEE Transactions on Software Engineering, doi: 10.1109/TSE.2019.2915065.


  - diversity sampling: each new test should be far way from the one before
    - e.g. all-pairs testing. No new test can mention any pair  x=v1 and y=v2 seen in prior tests.
     - so if ever you use _happy=true_ and _restDay=sunday_ then you can never test that pair again
    - so five inputs, 3 binary, one for "days of week" and one for something with ten values
      the all-pairs generation ipo.lisp](https://github.com/txt/se21/blob/61576862fed7549cd174fc392dc4441944cda910/docs/ipo.lisp)
      produces the following ("0" means "don't care")
    - note that is 68 tests, not  2\*2\*\7\*10 = 570 tests (and for larger input spaces, all-pairs offers even more 
       [dramatic reductions](https://github.com/jaccz/pairwise/blob/main/efficiency.md)).

```lisp
(ipo '(2 2 2 7 10)) ; ==>
((2 2 1 1 1) ; e.g. (true true true and first value of rest)
 (2 1 2 2 2) (1 2 2 3 3) (1 1 1 4 4)
 (2 2 2 7 5) (2 2 2 6 6) (2 2 2 5 7)
 (2 2 2 4 8) (1 1 2 1 9) (1 1 1 7 10)
 (1 1 1 6 5) (1 1 1 5 6) (2 1 1 3 3)
 (1 2 1 2 2) (2 2 1 7 9) (1 1 1 7 8)
 (1 1 1 7 7) (0 0 0 7 6)  ; note "0" means "don't care"
 (2 2 2 7 4) (0 0 0 7 3) (0 0 0 7 2)
 (1 1 2 7 1) (2 2 2 6 10) (0 0 0 6 9)
 (0 0 0 6 8) (0 0 0 6 7) (0 0 0 6 4)
 (0 0 0 6 3) (0 0 0 6 2) (0 0 0 6 1)
 (0 0 0 5 10) (0 0 0 5 9) (0 0 0 5 8)
 (0 0 0 5 5) (0 0 0 5 4) (0 0 0 5 3)
 (0 0 0 5 2) (0 0 0 5 1) (0 0 0 4 10)
 (0 0 0 4 9) (0 0 0 4 7) (0 0 0 4 6)
 (0 0 0 4 5) (0 0 0 4 3) (0 0 0 4 2)
 (0 0 0 4 1) (0 0 0 3 10) (0 0 0 3 9)
 (0 0 0 3 8) (0 0 0 3 7) (0 0 0 3 6)
 (0 0 0 3 5) (0 0 0 3 4) (0 0 0 3 2)
 (0 0 0 3 1) (0 0 0 2 10) (0 0 0 2 9)
 (0 0 0 2 8) (0 0 0 2 7) (0 0 0 2 6)
 (0 0 0 2 5) (0 0 0 2 4) (0 0 0 2 3)
 (0 0 0 2 1) (0 0 0 1 10) (0 0 0 1 8)
 (0 0 0 1 7) (0 0 0 1 6) (0 0 0 1 5)
 (0 0 0 1 4) (0 0 0 1 3) (0 0 0 1 2))


  - cluster the input space and only sample the "important" parts
    - but what does "importance" mean?
      - domain experts tells us that "A" never happens, but "B and D" happen a lot
      - some input clusters are more associated with errors that others (so here we are localizing inputs that might lead to failures)
      - for more on test failure localization, , see Jones JA, Harrold MJ, Stasko J. Visualization of test information to assist fault localization. Proceedings of the 24th International Conference on Software Engineering. ACM, Orlando, Florida, 2002; 467–477.
        - the branch weighting heuristics proposed by Jones et al. have been (exteslively)
         explored by others. For a small sample of that work, see Sarhan, Qusay Idrees, and Árpád Beszédes. "A survey of challenges in spectrum-based software fault localization." IEEE Access 10 (2022): 10618-10639.
        - for a review of other fault localization heuristics, see Zakari, Abubakar, et al. "Multiple fault localization of software programs: A systematic literature review." Information and Software Technology 124 (2020): 106312.
  - doodle a model (at which point your "black-box" becomes kind of a guess at "white-box" reasoning, see below)
    - Read the doc
    - Doodle a model showing expectations
    - Generate tests over that doodle <br> 
      <img width=500 src="https://github.com/txt/se20/blob/master/etc/img/fsm1doc.png"> <br> 
      <img src="https://github.com/txt/se20/blob/master/etc/img/fsm1.png">

- Fuzzing:
  - a structured approach to "throw stuff at random" at the program.
  - Barton Miller, University of Wisconsin in 1988.  Throw random cr\*p at a program till it crashed (brute force mutation)
    - when he was logged to a modem during a storm, there was a lot of line noise generating junk characters and those characters caused programs to crash
  - 1981: Duran and Ntafos investigated the effectiveness of testing a program with random inputs.
    - Random proves are a cost-effective alternative to more systematic testing
  - 1983: Steve Capps developed "The Monkey", a tool that would generate random inputs for classic Mac OS applications, such as MacPaint.
  - 2025 (Gerlacha, Joseph, Mathew, Menzies) for low-dimensional problems (less than 6 inputs), 50 random inputs works just as well as much more
    complex schemes.
  - Smart fuzzing #1: grammar-based fuzzing:
    - Express input as a grammar
    - Generate from tree
      - Generational fuzzing

```python
US_PHONE_GRAMMAR = {
     "<start>": ["<phone-number>"],
     "<phone-number>": ["(<area>)<exchange>-<line>"],
     "<area>": ["<lead-digit><digit><digit>"],
     "<exchange>": ["<lead-digit><digit><digit>"],
     "<line>": ["<digit><digit><digit><digit>"],
     "<lead-digit>": ["2", "3", "4", "5", "6", "7", "8", "9"],
     "<digit>": ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
}

[simple_grammar_fuzzer(US_PHONE_GRAMMAR) for i in range(5)]
['(692)449-5179',
 '(519)230-7422',
 '(613)761-0853',
 '(979)881-3858',
 '(810)914-5475']
```
  - Smart fuzzing #2: mutation:
    - Take a known valid input
    - Mutate it


```python
def mutate(s):
    """Return s with a random mutation applied"""
    mutators = [
        delete_random_character,
        insert_random_character,
        flip_random_character
    ]
    mutator = random.choice(mutators)
    # print(mutator)
    return mutator(s)

for i in range(10):
    print(repr(mutate("A quick brown fox")))


'A qzuick brown fox'
' quick brown fox'
'A quick Brown fox'
'A qMuick brown fox'
'A qu_ick brown fox'
'A quick bXrown fox'
'A quick brown fx'
'A quick!brown fox'
'A! quick brown fox'
'A quick brownfox'
```

  - Smart fuzzing #3: coverage:
   - Track parts of the grammar seen so far
   - Fuzz to some new place (fuzzing meets diversity sampling)

  - Smart fuzzing #4: mining examples to weight grammers:
    - Take a library of good examples
    - Weight sub-trees on (e.g.) Probability of not being "good"w
    - Stochastic recursive descent:
      - Stochastically select sub-trees according to their weights
        - If weight = random then generational fuzzing
        - If select to prefer min weights, then coverage fuzzing
      - Recurs into sub tree.
    

**White-box testing:** Writing tests with full understanding of the code. Tests are focused on exercising all code paths; logical decisions as both true and false, loops at their boundaries, and context-dependent testing of internal data structures.

- Coverage criteria (for finite-state machines)
  - _Test coverage_: cover every path: no feasible due to infinite number of paths (cycles)
  - _State coverage_: every node coverage (minimal testing criterion)
  - _Transition coverage_: every edge covered
    - E.g. here are five tests covering every edge

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


