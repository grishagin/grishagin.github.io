---
layout: post
title:  "How to Enable Call Recording in LineageOS"
date:   2022-02-18
categories: call recording lineageos android
tags: lineageos android
---

##### *from [XDA developers][xda1] and [Stackexchange][stack]

## Environment 
1. ADB
2. LineageOS 18.1
3. Windows 11
4. [Easy APK Tool][apk-tool]

## Instructions
1. Connect the phone to a PC with a USB cable.
2. Navigate to a directory with `adb.exe` 
3. Right click, `PowerShell` -> `Open here`
4. In the shell, execute:  
    ```bash
    cd /system/product/priv-app/Dialer
    cp Dialer.apk /storage/self/primary/Documents
    ```
5. On your phone, go to `Documents` folder, and move the `Dialer.apk` to your PC via email or IM.
6. Decompile `Dialer.apk` using Easy APK Tool.
7. Navigate to the corresponding decompiled `Dialer` folder, and there into subdirectory `res/xml`
8. Open `call_record_states.xml` in a text editor and replace all `false` strings with `true`
9. In `Dialer` folder, navigate into the subdirectory `res/values`
10. Open `styles.xml`
11. Line #25 is a duplicate, delete it:
    ```html
    <item name="android:textColorPrimary">@color/dialer_primary_text_color</item>
    ```
12. Using Easy APK Tool, recompile the `Dialer` folder into a new `Dialer.apk`
13. Upload the new `Dialer.apk` to the `Documents` folder on your phone. 
14. Reconnect the phone to a PC.
15. In the same PowerShell, run:
    ```powershell
    adb root
    adb remount
    adb shell
    ```
16. In the shell, execute:  
    ```bash
    mv /storage/self/primary/Documents/Dialer.apk /system/product/priv-app/Dialer
    cd /system/product/priv-app/Dialer
    chmod 644 Dialer.apk
    exit
    ```
17. Reboot:
    ```powershell
    adb reboot
    ```
18. When you start a call, a new button with a `Record` symbol will appear in the Dialer UI. 

[xda1]: https://forum.xda-developers.com/t/how-to-enable-native-call-recorder.3996233/?__cf_chl_tk=rcGcnnP.ylXpSqCBr0CZn3TponlXbGTV3T0erTEMceM-1645130498-0-gaNycGzNCJE
[apk-tool]: https://forum.xda-developers.com/android/software-hacking/tool-apk-easy-tool-v1-02-windows-gui-t3333960
[stack]: https://android.stackexchange.com/questions/162902/adb-push-not-working-on-system-read-only