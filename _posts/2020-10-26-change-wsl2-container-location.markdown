---
layout: post
title:  "Change Location of WSL2 Container"
date:   2020-10-26
categories: ubuntu 
tags: windows10 windows subsystem linux wsl2 ext4
---

##### *from [dev.to][devto]

WSL2 container is located on the `C:\` drive by default. 
This can be inconvenient, as it can grow to a substantial size.  
The size of the container becomes a particular concern considering that to reap WSL2's performance benefits, one should store the data directly in the container.  
While there are guides on how to import a new distribution via PowerShell, there's little information on how to simply move an existing container that is connected to an existing Linux WSL2 installation (e.g. `Ubuntu`).

1. Open PowerShell:
    ```console
    $ wsl --list --verbose
    ```
    Note the name of the distribution of interest:
    ```console
      NAME                   STATE           VERSION
    * Ubuntu                 Running         2
    ```

2. Shut down all WSL containers:
    ```console
    $ wsl --shutdown
    ```

3. Open the Windows Registry Editor and navigate to:
    ```
    HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\
    ```
    There, you will see the same number of keys as you have WSL distributions with random names, e.g. `{c5ce672c-4a91-40aa-b32e-6a149ea92380}`.  
    Inspect the contents of those keys, and specifically look for the value `DistributionName`.  
    Naturally, you're looking for the key with the `DistributionName` value equal to the name of your distribution of interest.  

4. Once located, Open the `BasePath` value. It'll look something like that: 
    ```
    C:\Users\IvanGrishagin\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState
    ```

5. Follow the path, where you'll find a file aptly named `ext4.vhdx`.  
    Copy this file to your new destination, e.g. `D:\VirtualMachines\WSL2\Ubuntu`.

6. Replace the path in the `BasePath` value with the new one (e.g. `D:\VirtualMachines\WSL2\Ubuntu`). 

7. All done!


[devto]: https://dev.to/milolav/manually-installing-wsl2-distributions-41b4

