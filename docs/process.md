% Process

## People (the most powerful Technology)




### People Tools 1:  Inspections


People, read stuff.


Different people  are told to read for  different things
-  reduces load of each one  person
-  prevents double  up


Can be applied to any artifact,  any technology
- Don't have to wait for  (e.g.)  updates to latest version of the parser
- Needs no tools, no  licenses


You can  inspect anything
- designs:  collect "users stories" then run  the  stories.
  - see where the design falls  off the edge
- tests:  manually run some "what-ifs" throogh  the code
For more, [see here](https://faculty.washington.edu/ajko/books/design-methods/#/analytical).


### People Tools 2:: Planning Poker


Ego-less way to do  effort  estimation


[Wikipedia](https://en.wikipedia.org/wiki/Planning_poker)


<img  width=600 src="https://user-images.githubusercontent.com/29195/131859590-853f2abf-5e36-4c8d-ac7a-0b87c8c47db8.png">

## Process Notes




Let us consider two extremes of software process: waterfall vs scrumm


<img width=700 src="https://github.com/txt/se23/assets/29195/52c259a7-f480-422e-8f0a-b0acb33cfc8f">


Both are management tools for controlling software development.


### (aside: what is "Agile")


- Scrum is a type of agile
- Scrum is broken down into shorter sprints and smaller deliverables
-  In Agile, that is optional. In fact everything might be  delivered at the end of the project


<img width=700 src="https://github.com/txt/se23/assets/29195/78ceea76-1e54-44fa-9cbd-b333870545b2">


### Waterfall


- Making a good plan and sticking to it
-  Very efficient for well-defined projects


Large strategic control. Linear order of tasks:
- Requirements
- Analysis
- Design
- Code
- Test
-  Deploy


Experience gained from step i+1 only allowed to feed back to step i


Used for:


- For less complex projects with well defined requirements, processes and roles for team members.


- For large military or government contracts, often need to get approval for resources before moving ahead.
  - In that context, the thing you are building is defined once at the start during a complex negotiation process
       known as the “requirements stage”
- For very long projects, software companies can’t afford to wait to the end to get paid.
  - Waterfall offers landmarks along the way where non-programmers (read, accountants) can check off that some task is
    completed (so they can pay for that stage).
- Hware/Sware co-design (see notes at end).


Less than useful when:


- Too much rigidity built into the project.
- Mid-project pivots require extensive re-engineering of the solution so far.
- When experience downstream in the process leads to massive changes to all ideas upstream (e.g. consider a single test shows that the whole system is too slow and needs massive redesign).
- Analysis paralysis: too much paper-driven activity, very little working code.


### Scrum


- Adapt, Improvise, Overcome
- High flexibility


- Smaller scale tactical meetings.
- A cycle that repeats in short cycles  (weekly or monthly)


Sprints:
1.    Review a backlog of “things to do”
2. select the things that deliver the most value at least cost.
3. Sprint to complete those tasks before the next review (next week, next month)
4. Go to step1


Daily meetings:
- Daily: run a meeting where everyone is standing up.  Ask everyone 3 questions:
- What have you accomplished since we last met?
- What do you plan to accomplish before the next meeting?
- What issues or problems are you currently facing?


Very useful when:


- When a project is based on incremental progress, complex deliverables or consists of multiple, not always sequential timelines.
- When dealing with small groups whose skills you trust, and no one is negotiating for specific dollar amounts before going ahead with the work.
- When running agile.
- When early feedback from running code can radically change your goals and designs.


Less than useful when:


- When small incremental change gets harder and harder since the overall architecture is now a mess.
- The project lost direction or is falling behind schedule.
- Constant iteration and re-alignment of the project is stretching budgets and timelines


### Notes from recent meetings with industry


AgileFall:
- we **say** we are agile but , actually, we **do** waterfall.


From an industry person: "have to get agile out of our copamany"
- for hardware / software co-design,  h/ware developers need a solid target for their work
- e.g. 4-6 month cycle
  a. Why,What,Who: motivations, users, user stories, high level decisions
  b. How : lower-level design
  c. Code :
  d. Test : including h/ware integration
- Note: same people, cloud platform,s happy to see abcd cycles as short as 1 week.


## Repo Branching Stragties 


 Distributed (e.g.GH) versus centrailized (e.g. SVN)


- Distributed (e.g. GIT)
  - Operates locally so you can work on offline, without a network


  - No Aa single point of failure. Any "main" repository can be restored from
    a local copies.
  - Very good at merging.
  - All users can acccess all parts of repo (great for coding, bad  for security)
  - Problems with large binaries
  - Higher learning curve. Commit? then push? Say what?


```
You can squelch this message by running one of the following
commands sometime before your next pull:


  git config pull.rebase false  # merge (the default strategy)
  git config pull.rebase true   # rebase
  git config pull.ff only       # fast-forward only
```


- Centralized (e.g. SVN)
  - centralized "boss", and many "workers"
  - easier mental model (for newcomers)
  - contributor’s access can be limited to particular directories
    and files (good for secutiry)
  - Efficiently stores large binary files.
  - Limited off-line supports
    (everything operates on a
     centralized repository using a client-server approach)
  - Centralized repository server can be a single point of failure.




## Branching Strategies




### Branching method 1: Don't do it

  How to branch (approach-1: don’t bother, for small projects)


- No branches. Everyone checks out and commits to main
- Consider not branching for small teams:
  - Divide things up into lots of small files
  - Everyone commit and pull at high  frequency (many times per day)
- Why that’s a good idea
  - Your current code base is initially too small to be hard structured
  - Also, this fails often enough to show you why version control is so important


### Branching method2: git flow

Each branch is an experiment with a new feature.

<img width=700 src="https://user-images.githubusercontent.com/29195/130551955-f25cab13-55f1-48c2-a3f8-a6c3c759e82a.png">


- When a team  branches, they are promising to return with some new cool feature.
- When the team comes back to main,    people expect to see that promise delivered.
- Code is thoroughly vetted before being merged
- Good for large scale, not-so-fast, distributed development
- E.g.
  - https://github.com/marcotcr/lime
  - https://github.com/elacx/lime


Beware gitflow hell

<img width=700 src="https://user-images.githubusercontent.com/29195/130552057-1891deda-3328-43c7-8fab-c139cff3d1ff.png">


Git flow tips

- Good when
  -  When you run an large, slow open-source project.
     - Everyone can contribute
     - You’ll need to be able to check every single line of code,
        - because well you can’t trust people contributing.
  - When you have a lot of junior developers.
     - you want to have a way to check their work closely
  - When you have an established product.
    - So branches are small changes, bounded by something much larger
- Not so good when
  - When you are just starting up.
    - Chances are you want to create a minimal viable product quickly.
    - Doing pull requests creates a huge bottleneck that slows the whole team down dramatically
  - When you need to iterate quickly.
  - When you work mostly with senior developers
    - Who mostly don’t mess things up


### Branching method3: Trunk-based Development


(used at Google,Facebook, Amazon: https://trunkbaseddevelopment.com)


Developers collaborate on code in a single branch called “trunk” (\*), resist any pressure to create other long-lived development branches. Avoids merge hell, do not break the build, and live happily ever after.


(\*)  master, in Git nomenclature


Very short lived feature branches: one person over a couple of days (max). Much build automation before merging into main


<img width=700 src="https://user-images.githubusercontent.com/29195/130552454-aa8c1fc0-7927-4072-b31a-263677c5ca86.png">


Merge hell or trunk-based? You decide. Compare this  to  above:


<img width=700 src="https://user-images.githubusercontent.com/29195/130552521-4bef7f5a-b861-4f9a-947c-32e9b6aadf70.png">



## Standard Files


- **README.md** - landing page for GitHub repository web page
    - Zenodo doi badge
        - https://zenodo.org/account/settings/github/
    - License  badge
    - Test  suite badge
    - Code coverage badge
- **LICENSE.md** - license for repository
    - https://www.youtube.com/watch?v=oHNKTlz1lps
    - https://choosealicense.com/
    - Understand what a real Apache-license  project looks like
        - https://github.com/zephyrproject-rtos/zephyr/releases/tag/zephyr-v2.6.0
- **.gitignore** - used to ignore files from being committed to the repository
    - https://github.com/github/gitignore
- **.gitattributes** - used to provide per-repository settings for all developers
- **.github** Folder - provide issues template, pull request template, and README.md
    - https://github.com/timm/keys/tree/main/.github/workflows
- **requirements.txt**: things  to install first (or equivalent in your language)
- **INSTALL.md**: install instructions more complex than requirements.txt
- **[setup.py, __init\__.py](https://github.com/bmcfee/spatialtree)** (or equivalent in your language)
- **CONTRIBUTING.md:**
    - https://gist.github.com/PurpleBooth/b24679402957c63ec426
    - https://github.com/atom/atom/blob/master/CONTRIBUTING.md
- **CODE-OF-CONDUCT.md**:
    - https://chromium.googlesource.com/external/github.com/coreos/seismograph/+/edbe2360e9af362914868df0c7c1ace62e8e1778/code-of-conduct.md


## Case Study (Black)

<img width=800 src="https://user-images.githubusercontent.com/29195/130550744-02b6b5b3-2ced-45a2-8d57-ea75b3708988.png">


## Case Study (Zephyr)

15 real-time operating systems 2018, 2020

Why is the Zephyr operating  syste,s succeeding so well?
- Perception of open governance (no one owns it)
- So you can contribute, without anyone  ever locking away your work
- AND you can get everyone else’s contributions


<img width=700 src="https://user-images.githubusercontent.com/29195/130550329-18ca9f19-13ed-4fe5-bb70-d3a54dbca4ce.png">


<img width=700 src="https://user-images.githubusercontent.com/29195/130550433-bb6c8952-df95-42de-81b6-573c9b3cf014.png">


<img width=700 src="https://user-images.githubusercontent.com/29195/130550489-4bc8e2a2-fd66-4b8a-b0a9-adba362df3ef.png">

## Shields.io

<img width=700 src="https://user-images.githubusercontent.com/29195/130550982-484c0f92-0033-4f90-9e51-a29ae62eabcd.png">

