---
layout: post
title:  "How to Install Lisp on Windows 10"
date:   2017-01-26
categories: lisp windows10
tags: windows10 common lisp clisp
---

##### *from [Jonathan Fischer][fischer] and [YouTube][baggers]*

### Download

1. [Common LISP][clisp].  
2. [Emacs][emacs] -- editor / "IDE".  
3. [Quicklisp][quicklisp] -- key LISP library that allows to download and maintain other libraries with ease.  

### Install 

1. Install Emacs.
   - Unpack contents of Emacs archive
   - Start **>** type "envir" **>** select ```Edit the system environment variables``` **>** click ```Environment variables...```
   - Under ```System variables``` double-click ```Path```
   - Click ```New```, and in the prompt add path to the Emacs ```bin``` folder, e.g. ```C:\ntemacs24\bin```, then click ```OK```   
2. Create home directory.  
Under ```System variables``` click ```New...``` and create a new variable with Name ```HOME``` and value ```C:\HOME```.  
This is necessary to avoid problems with home directory recognition by lisp. 
3. Install CLISP.  
   - Create an easy-to-reach, easy-to-use directory. I use ```C:\lisp```.
   - Install CLISP in that directory.  
   **NOTE:** the latest version at the time of writing is 2.49, but I’m having trouble getting it to load SLIME properly (see below), so version 2.48 it is. (file ```clisp-2.48-win32-mingw-big.exe```).  
   - **Important:**  
   Installer of the version 2.48 is faulty.  
   To fix this problem, copy ```svm.dll``` out of ```clisp-2.48/libsvm``` directory into ```clisp-2.48/full```.
4. Install quicklisp.  
   - Place ```quicklisp.lisp``` into ```C:\lisp```  
   - Run CLISP and execute the following:  
   
   ```lisp
   (load "C:/lisp/quicklisp.lisp")
   (quicklisp-quickstart:install :path "C:/lisp/quicklisp/")
   (ql:add-to-init-file)
   ```
5. Install SLIME -- an Emacs extension to make lisp development seamless.  
In the CLISP console execute:
   
   ```lisp
   (ql:quickload "quicklisp-slime-helper")
   ```
6. Configure Emacs. 
   - Launch Emacs
   - Type ```Ctrl-x```, then ```Ctrl-f```
   - Enter ```~/.emacs``` in the prompt at the bottom of the window
   - Add the following lines to the file:
   
   ```
   (setq inferior-lisp-program "clisp.exe")
   (load "C:/lisp/quicklisp/slime-helper.el")
   ```
   
   - Type ```Ctrl-x```, then ```Ctrl-s``` to save the file.

   

[fischer]: http://www.jonathanfischer.net/modern-common-lisp-on-windows/
[baggers]: https://www.youtube.com/watch?v=VnWVu8VVDbI
[clisp]: https://sourceforge.net/projects/clisp/files/clisp
[emacs]: http://ntemacs.sourceforge.net/
[quicklisp]: http://beta.quicklisp.org/quicklisp.lisp