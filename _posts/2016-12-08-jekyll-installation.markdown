---
layout: post
title:  "Installing Jekyll via Bash on Ubuntu on Windows 10"
date:   2016-12-08 15:38:37 -0500
categories: jekyll
---
Here's what worked for me.  
NOTES:  
* Code formatting using \`\`\` is fine when serving the site locally, but is broken on github.  
As such, using \{% highlight %\} style is mandatory.  

### Ruby 
#### *from [Dave Rupert][daverupert]*  
{% highlight bash %}
$ sudo apt-add-repository ppa:brightbox/ruby-ng  
$ sudo apt update  
$ sudo apt install ruby2.3 ruby2.3-dev ruby-switch  
$ ruby -v  
{% endhighlight %} 

### Python 2.7.12  
##### *from [tecadmin]*  
{% highlight bash %}
$ sudo apt-get install build-essential checkinstall  
$ sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev  
$ cd /usr/src  
$ sudo wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz  
$ sudo tar -xzf Python-2.7.12.tgz  
$ cd Python-2.7.12  
$ sudo ./configure  
$ sudo make altinstall  
{% endhighlight %} 

### Jekyll  
##### *from [Jekyll][jekyllrb]*  
{% highlight bash %}
$ sudo gem install jekyll  
$ sudo gem install jekyll bundler  
$ sudo gem install minima  
$ sudo gem install jekyll-feed  
$ cd /mnt/d/git/grishagin.github.io  
$ jekyll new .  
{% endhighlight %} 






[daverupert]: http://daverupert.com/2016/04/jekyll-on-windows-with-bash/
[tecadmin]: http://tecadmin.net/install-python-2-7-on-ubuntu-and-linuxmint/
[jekyllrb]: https://jekyllrb.com/docs/quickstart/