% HW1: A beautiful repo

<br clear=all>

## What to hand in:

- A one page pdf with a screen snap from point6 
- On that page, also write the  url to the repo crated below.  (where we can look at all your wonderful badges).

Note:

- Points 1..9 are easy.
- Points 10,11,12,13 will require much messing around with web-based help files. Go work it out.
- Point 14 is optional.

## Todo 

1. Your team should create an organization on Github
2. Crate a repo in that organization. Make it public.
3. Find the  big green CODE button. Create a new workshop on main.
4. In the terminal, install  python3.13 by running the following command (it is all on one line).
Then check you have python3.13.
```sh
sudo apt update -y; sudo  apt upgrade -y; sudo apt install software-properties-common -y; sudo add-apt-repository ppa:deadsnakes/ppa -y ; sudo apt update -y ; sudo apt install python3.13 -y
```
```sh
python3.13 -B --version
```
5. Now write a short python program (10 lines) and add an error.
   From the command line,  run that file.
You should see errors on the command line.
VSCode should now be asking if you want Python support installed. Do it.
```sh
python3 myfile.py
```
6. Run the code again. Take you mouse and point to one of the errors on the screen. Observe
how it highlights like a hyperlink. Take a screen snap of you point to that error. Include the whole
window so we can see you can see the code and error at the same time.
7.  Go to https://choosealicense.com/licenses/ and find text for your license of choice.
    Change  /workspaces/LICENSE.md to have that content.
8. Goto  to https://github.com/github/gitignore and find the VisualStudio.gitignore and the Python.gitignore.
   Add all that content to /worskspaces/.gitignore
9. Go to http://shields.io and https://dev.to/envoy_/150-badges-for-github-pnk and work out how to add a bade to a markdown file.
  Go to /workspaces/README.md. Delete its contents.  Add badges to the top for 
  - language python
  - license bsd-2   (or what ever you selected)
  - platform linux
10. Look up "pytest". Add a test engine to you code. Add two tests: one that fails, one that passes.
    - Important: make the tests in a SEPARATE file to your code file.
11. Look up how to do a Python workflows. https://docs.github.com/en/actions/use-cases-and-examples/building-and-testing/building-and-testing-python#testing-with-pytest-and-pytest-cov
12. Make your code auto test each time you commit (using the workflows)
13. Add a badge showing if your tests pass or fail. See https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/monitoring-workflows/adding-a-workflow-status-badge
14. Optional. Add a code coverage  badge.





