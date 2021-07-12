---
layout: post
title:  "Windows Terminal: Run PowerShell as Administrator"
date:   2021-07-12
categories: windows terminal 
tags: windows terminal powershell gsudo
---

##### *from [GitHub: Windows Terminal Issue 691][github-691], [GitHub: gerardog/gsudo][github-gsudo]

Currently, Windows Terminal does not support running individual tabs as Administrator.  
There is an elegant workaround employing a third-party application, `gsudo`.


1. Start PowerShell as Administrator.

2. Run:
    ```powershell
    choco install gsudo -y 
    ```
    **Note:** you don't need chocolatey; refer to the [gsudo source][github-gsudo].

3. Open Windows Terminal -> `Settings` -> `Add new`

4. Under `Command line` add this:
    ```powershell
    pwsh.exe -Command "gsudo pwsh"
    ```
    **Note:** `pwsh` is for PowerShell 7 (if you have it). This works equally well for the default PowerShell: just replace `pwsh` with `powershell`.

5. Change the tab icon to distintuish it from the non-elevated version.  
[Here's a red one][red-pwsh-icon].

[github-691]: https://github.com/microsoft/terminal/issues/691
[github-gsudo]: https://github.com/gerardog/gsudo
[red-pwsh-icon]: {{ site.url }}/downloads/posts/powershell.ico