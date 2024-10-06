#autocommit
##Introduction
Autocommit is a desktop/laptop application to do git commit at any time. Its primary purpose is for use when writing code with the QB64 Phoenix Edition IDE, but in theory could be set up for use with other programming environments. While it is written to be used on Windows, I think it could be recompiled for use on Linux (once I have the code to shell out to Git set up so that the Linux command sequence can be used.)

##Reason for ths program
Unlike with the typical write code - use make to build - compile and test routine, with a self-contained compiler and IDE, there's no place in the workflow to insert a command to automatically commit changed files to a source code control / version management system. This allows you to click one window and the commit is done for you.

##Intended adience
This program is intended programmers to make a version change before committing code to the repository, on the pressumption that you've just made some changes, you saved them, you're having the IDE recompile your program, so you do a commit. Personally, I prefer to do commits either after signifcant multi-line changes have occurred, and were saved, or on any recompile after change and save.

It is possible to revise this program (or create an optional version) to commit first, then update the version number, but I think this method is more closely related to how programs are created in this work environment.

##What it does
Right now, the program collects the info from the Version.bi file, updates version number and other information, replaces it, then issues a commit request to git. It also has a help function that gives a general explanation of how it works.

##Command-line options
  -h 		(Actually, only the first letter is checked) Displays the <br/>
  --help	help message and quits
  /h 
  
 directory-name		Change to that directory to start. If no directory is specified, the					directory where Autocommit is located is used.

##Warning
NOTE: The program is posted here so that when it is finshed (or at least, feature complete to be useful), others can use it. This program is still in development and does not work. Check back later.
