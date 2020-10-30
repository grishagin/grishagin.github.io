---
layout: post
title:  "Install/Configure VirtualEnvWrapper"
date:   2020-10-30
categories: ubuntu 
tags: python virtualenv virtualenvwrapper
---

##### *from [readthedocs][readthedocs], [Stack Overflow (1)][stack1], [Stack Overflow (2)][stack2]

```bash
# 1. Install
pip3 install virtualenvwrapper

# 2. Create a directory for your environments
$ mkdir py-envs/

# 3. Add a path to where virtual environments will be stored to your profile
$ echo "export WORKON_HOME=~/py-envs" >> .profile

# 4. Add a path to the correct python symlink or executable to your profile
$ echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> .profile

# 5. You need to run this shell script at the start of every session, so add it to your profile
$ echo "source /usr/local/bin/virtualenvwrapper.sh" >> .profile

# 6. Source
$ source .profile

# 7. Commands are available now, e.g., to make and load an environment:
$ mkvirtualenv env1
$ workon env1
(env1)$ 
```



[readthedocs]: https://virtualenvwrapper.readthedocs.io/en/latest/
[stack1]: https://stackoverflow.com/questions/29486113/problems-with-python-and-virtualenvwrapper-after-updating-no-module-named-virtu/29508117
[stack2]: https://stackoverflow.com/questions/29900090/virtualenv-workon-doesnt-work

