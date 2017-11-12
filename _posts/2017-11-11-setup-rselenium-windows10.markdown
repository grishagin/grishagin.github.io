---
layout: post
title:  "How to Setup Environment for RSelenium on Windows 10"
date:   2017-11-11
categories: r rselenium
tags: r rselenium windows10 docker
---

<style type="text/css">
.docker-console {
	width: 600px;
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>

##### *from [RSelenium vignette][rselenium], [RPubs][rselenium-rpubs], and [Docker GitHub][boot2docker-issue]*  

RSelenium moved to using Docker, which allows to standardize package behavior across operating systems, and therefore remove all concomitant issues.

### Download and Install
1. [Docker][docker], an environment to run Selenium server.
2. [TightVNC][tightvnc], a viewer to observe the result of RSelenium navigation commands. 


### Setup Docker to work with Selenium
1. Enable [hardware virtualization][hyperv]. It is sufficient to enable it in BIOS, and subsequent steps are unnecessary. 
If you don't have it enabled, Docker will throw the following error:   
```console
This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory.
```

2. Save [this json file][boot2docker-json] as ```latest.json``` into ```/Users/{user}/.docker/machine/cache/```.   
Upon starting, Docker will download ```boot2docker.iso```.   
Without it, you most likely will see the following error upon Docker launch:   
```console 
No default Boot2Docker ISO found locally, downloading the latest release...
``` 

3. Start ```Docker Quickstart Terminal```. You should see a console prompt similar to this one:   
![Docker Console]({{ site.url }}/assets/docker-console.png){: .docker-console}

4. In Docker Terminal run the following commands:
```console
$ docker pull selenium/standalone-chrome
$ docker run -d -p 4445:4444 selenium/standalone-chrome
```
A full list of Selenium Docker images is available [here][selenium-docker-images].

5. Alternatively, for debug mode (to enable viewing results of RSelenium navigation) use:
```console
$ docker pull selenium/standalone-chrome-debug
$ docker run -d -p 5901:5900 -p 4445:4444 selenium/standalone-chrome-debug
```
Then start the ```TightVNC```.  
In the prompt, enter ```192.168.99.100:5901``` as ```Remote Host:``` and click ```Connect```.   
In the next window enter ```secret``` as ```Password:```.  
The result of all RSelenium navigation commands can be seen in this window.


### Connect R Session to Selenium Server
In R, create a ```remoteDriver``` object, and navigate to a desired url:
```R
#load RSelenium package
require(RSelenium)
#point to the remote server
remDr<- 
       remoteDriver(remoteServerAddr = "192.168.99.100" 
                    , port = 4445L 
                    , browserName = "chrome"
					)
#navigate to url
remDr$open()
remDr$navigate("https://www.google.com/")
```

[rselenium]: https://cran.r-project.org/web/packages/RSelenium/vignettes/RSelenium-basics.html
[rselenium-rpubs]: https://rpubs.com/johndharrison/RSelenium-Docker
[boot2docker-issue]: https://github.com/docker/machine/issues/3210

[docker]: https://docs.docker.com/toolbox/toolbox_install_windows/
[tightvnc]: http://www.tightvnc.com/download.php

[hyperv]: https://blogs.technet.microsoft.com/canitpro/2015/09/08/step-by-step-enabling-hyper-v-for-use-on-windows-10/
[boot2docker-json]: https://api.github.com/repos/boot2docker/boot2docker/releases/latest

[selenium-docker-images]: https://hub.docker.com/u/selenium/


