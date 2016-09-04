# Version Control with RStudio and Github
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## Learning Objectives

You will learn:

* What version control is and _why you should care_
* The basic operations of the _Git_ version control system
* How to use Git and Github to _manage projects_
* How to use Git and Githhub _from within RStudio_

## Version Control

The following is true of most modern version control systems:

* A method for _tracking changes_ to one or more _files_
* Like Apple Time Machine with "Track Changes" of MS-Word
* Makes changes to one or more files as a _single_ "commit"
* Works with _any type of file_, especially plain-text and "code"
* Allows _multiple users_ to work with the same files _concurrently_
* May also be called: _revision control systems_

## Version Control Features

Most modern version control systems:

* Provide _logging_ and _status reports_ for ease of tracking
* Allow you to _compare_ versions or _revert_ to past versions
* Let you _share_ files and _merge changes_ from others
* Handle merging for you, _transparently_ (in most cases)
* Let you _collaborate_ through a _server_ or website like [Github](https://github.com/)
* _Sync_ changes with the server instead of ~~emailing files around~~

## Git: Distributed Version Control

* Hugely popular, free, open source, and cross-platform
* _Distributed_, decentralized design allows offline use
* _Integrated_ with apps like _RStudio_ and MS Visual Studio _Code_
* The version control "engine" behind sites like [Github](https://github.com/)
* Created by _Linus Torvalds_, the creator of Linux
* Designed for _large_ projects with many _remote_ contributors
* Increasingly popular for _scientific research projects_

## Github: Social Version Control

* The most popular web-based host of Git repositories
* Repository browser with syntax highlighting and text editing
* Integrated issue tracking, stats, and wiki
* Offers "forking" and "pull requests" for collaboration workflow
* Hosts Github Pages (github.io) and Github Gists (gist.github.com)
* Provides Github Desktop for Mac and Windows and Github Atom editor

## Installing Git

* Installers available from: [https://git-scm.com/](https://git-scm.com/)
* For Windows installer, _allow changes to the system PATH_
* RStudio searches PATH to find "git", or manually configure
* Git is _already installed_ on Phage

## Configuring Git

* You need to [configure](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup) 
your username and email address.
* Configuring for default editor and color support is nice, too.
* Run these commands from the "shell" (Bash, DOS, etc.).

```
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
git config --global color.ui true
git config --global core.editor nano
```

Edit these commands as needed for your name, email, and preferred editor. 

If you store them in a shell script, you may easily run them on other systems 
you may be using. For now, copying, pasting, editing, and running will be fine.

## Git Integration in RStudio

* RStudio can import (`clone`) a git project from a server
* RStudio can perform all _common_ operations from the GUI
    + From the menu: _Tools_ -> _Version Control_
    + From the _Git_ tab next to the _History_ tab

## Common Git Operations

| Command  | What it does
|----------|----------------------------------------------
| `clone`  | Copy a repository into a new folder
| `pull`   | Fetch and integrate changes
| `commit` | Record changes to the repository
| `push`   | Send changes to remote repository (server)
| `diff`   | Show changes between commits
| `log`    | Show commit logs
| `status` | Show the current status of files and changes

## Git and GitHub Glossary

- **Repository (repo):** A repository is the most basic element of GitHub. They're easiest to imagine as a project's folder.
- **Branch:** A parallel version of a repository
- **Clone:** Local copy of the repository
- **Commit:** An individual change to a file (or set of files). Commits usually contain a commit message. 
- **Fork:** A personal copy of another user's repository that lives on your account
- **Merge:** Merging takes the changes from one branch (in the same repository or from a fork), and applies them into another.
- **Pull:** Pull refers to when you are fetching in changes and merging them.
- **Pull Request:** Pull requests are proposed changes to a repository submitted by a user and accepted or rejected by a repository's collaborators
- **Push:** Pushing refers to sending your committed changes to a remote repository such as GitHub.com

[More details here](https://help.github.com/articles/github-glossary/)

*Thanks to Raphael Gottardo for this slide from his Biostat-578
 [lecture](https://github.com/raphg/Biostat-578/blob/1352ca32c7f12ec8b43f8898cce5cae3831e7a43/Introduction_to_R.Rmd).*
 
## Typical Git and Github Workflow

### Project initialization

1. Create a new, empty repo in Github
2. `clone` to local system or `push` from existing local repo to Github
3. Create README, LICENSE, and .gitignore files, then push/pull to sync

### Project continuation

1. Add collaborators to Github repo if needed
2. Always do a pull when you begin a work session and before a commit
3. To commit changes, `add` changed files, `commit` with a message, and `push`
4. Check your Github "Issues" and resolve issues as separate commits
5. Check your pull requests, review the code, merge (or not), and close

## Exercises

### Exercise #1

Clone a git repo into RStudio as a new project.

### Exercise #2

Create a Github account (if you need to) and use your account to fork a repo.

### Exercise #3

Clone your fork from exercise #3 into RStudio, make an edit, push your edit to Github.

### Exercise #4

Complete exercises #2 and #3 and then issue a pull request to the original 
repo author for your changes to your fork.
