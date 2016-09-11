# R's Interactive Prompt
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## Learning Objectives

You will learn:

* Where to find the R prompt
* How the prompt works
* How to use the output
* Keyboard Shortcuts
* How to Restart R

## The Prompt is in the Console

The interactive R prompt is usually found or starting within a "console". 

* In RStudio, you have a Console pane. 
* In other applications, you have a Terminal window of some sort.
* The features vary, but this is mostly a text-only interface.
* That means, the mouse is only good for cursor location and copy/cut/paste.

## How the Prompt Works

* The prompt waits for commands
* You type a command at the prompt and press *Enter* (or *Return*)
* R will parse your commands and try follow them
* R will either show an error, show results, or silently complete the task

## How to use the output

How R can return data to you:

* R can show data to the screen
* R can save data to a variable (in memory)
* R can save data to a file (on your disk or the network)
* R can save data to a database (either locally or over the network)

Usually, you manipulate data in memory and then save it to a file or database
when you are done working with it.

While you could copy text results shown to the screen and paste them elsewhere,
this method will be of limited use.

## Keyboard Shortcuts

It pays to know keyboard shortcuts to minimize use of the mouse.

* Select text: Press *Shift* and move left or right with arrow keys
* Select entire line: *Ctrl-a* or *Cmd-a* (Mac) 
* Copy selected text: *Ctrl-c* or *Cmd-c* (Mac)
* Cut selected text: *Ctrl-x* or *Cmd-x* (Mac)
* Paste text from clipboard: *Ctrl-v* or *Cmd-v* (Mac)
* Move to beginning of line: *Home* or *Cmd*-*Left Arrow* (Mac)
* Move to end of the line: *End* or *Cmd*-*Right Arrow* (Mac)
* Traversing the line by character: *Left Arrow* and *Right Arrow*
* Traversing your command history: *Up* and *Down* arrow keys
* Scrolling up and down through the Console screen: *PgUp* and *PgDn*

There are a [bunch more](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts) of these. Over time, the savings in effort add up!

## Restarting R

If R get's stuck, or you would just like to start with a fresh R session 
(to clear variables and packages), try...

In RStudio's Console pane:

* From the menu: Session -> Restart R
* With a keyboard shortcut: Cmd/Ctrl - Shift - F10
* With an R comand: `.rs.restartR()`

In any R console:

* Quit the session with `q()` (or from the menu) and start a new session
* Close the window and launch a new one (you might lose work, though)
