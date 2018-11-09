---
layout: post
title:  "Setup R on Ubuntu"
date:   2018-10-29
categories: r ubuntu 
tags: r ubuntu windows10 tidyverse subsystem linux wsl
---

##### *from [Michael Rutter][mrutter], [Stack Overflow][stack], and (of course) trial and error

Installing and setting up R on Ubuntu can be a frustrating experience due to multiple system dependencies.

### Install R from a Personal Package Archive by Michael Rutter
Check for the current version [here][mrutter] before the installation.
```console
$ sudo add-apt-repository ppa:marutter/rrutter3.5
$ sudo apt-get update
```

### Install Key Package Dependencies
In Windows, external R package dependencies (except Java) are installed automatically, and users are frequently unaware what is happening behind the scenes.  
In a linux environment, the same dependencies require explicit installation via the linux package manager.
1. Install Java
```console
$ sudo apt-get install default-jre
```

1. Install Curl
```console
$ sudo apt-get install libcurl4-openssl-dev
```
In the future, check for the current curl version:
```console
$ apt-cache search libcurl
```
2. Install OpenSSL
```console
$ sudo apt-get install libssl-dev
```
3. Install LibXML
```console
$ sudo apt-get install libxml2-dev
```

[mrutter]: https://launchpad.net/~marutter/+archive/ubuntu/rrutter3.5
[stack]: https://stackoverflow.com/questions/31686470/install-curl-and-readr-on-r



