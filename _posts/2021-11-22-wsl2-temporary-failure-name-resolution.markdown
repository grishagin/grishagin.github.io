---
layout: post
title:  "WSL2: Temporary Failure in Name Resolution"
date:   2021-11-22
categories: wsl2 dns ubuntu
tags: wsl2 dns ubuntu
---

##### *from [GitHub: Windows Terminal Issue 5420][github-5420], [GitHub: Windows Terminal Issue 5256][github-5256]


In WSL2, run: 
```bash
# remove existing resolv.conf symlink that is pointing to a wrong nameserver
sudo rm /etc/resolv.conf
# create a new resolv.conf with a correct nameserver
sudo bash -c 'echo "nameserver 1.1.1.1" > /etc/resolv.conf'
# stop wsl from regenerating resolv.conf symlink
sudo bash -c 'printf "[network]\ngenerateResolvConf = false" > /etc/wsl.conf'
# make current resolv.conf immutable so that wsl does not delete it
sudo chattr +i /etc/resolv.conf
```

In powershell, run 
```powershell
wsl --shutdown
wsl
```

[github-5420]: https://github.com/microsoft/WSL/issues/5420#issuecomment-646479747
[github-5256]: https://github.com/microsoft/WSL/issues/5256#issuecomment-666545999