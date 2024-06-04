# fastfind
## 1. [Screenshot]

![image-20240603172210739](readme.pic/image-20240603172210739.png)

![image-20240603172508178](readme.pic/image-20240603172508178.png)

![image-20240603174233244](readme.pic/image-20240603174233244.png)

Have a fun!~~

<br />

## 2. [Background]

It's a tool designed for C++ symbol find based on shell. 

It works under:

- git-bash shell on Windows 
- zsh on Mac.

Maybe it can fit other shell-env, but not test is performed

The idea of this tools comes from the terrible experience in using vs-code on WebRTC source code. There is no symbol colorful highlight, and no category in search result in vs-code. There are always so many results when search, so that you need to take too much time to find the focus you really care about.  And also on Mac, the IntelliSense and C++ extension does not work well as you expect, the performance on Mac can not be endured. 

This tool is designed to show respect to the visual assist which is the powerful extension of visual studio for C++ on Windows.

You can use command "ffse-help" to get some help. 

For historical reason, there are something named with "ffse" which means "fast-find-symbol extension", and now it's the 3rd version, so you can find something with the name "FF3_XXX" or "FFSE" in the shell script. Don't be surprised when you see those names.......

<br />

## 3. [Tool Init]

To init the tool, just:

1. put the ".fast_symbol_finder3.sh" in your home directory. To get your home directory, you can use:

```shell
#on windows 
echo %USERPROFILE%

#on mac
echo $HOME
```

2. then go to the webrtc "src" directory

3. run the init command:

```shell
ffse-init
```

"ffse-init" will prepare all the source file lists, used by fastfind, except for the "ignore.list". "ignore.list" is a list customized by your self. Refer to chapter 7.1 in this readme for more info on "ignore.list". You can also use the "ignore.list" in the directory of [ref_list](https://github.com/gimphammer/fastfind/tree/master/ref_list), if you are working with the M97 of WebRTC. And put it under the WebRTC root directory like this:

![image-20240604131613818](readme.pic/image-20240604131613818.png)

<br />

## 4. [Command usage]

### 4.1 Basic Command

- fc [symbol]  -- to find where the symbol is used, or the function is called

- fs [symbol] -- find all symbol in code base

- fdd [class-name] -- find all the class derived from the class named by [class-name]

- fdc [class-name] -- find who is the father class for  [class-name]

- ff [symbol]  [file-in-relative-path] -- find all the symbol named by [symbol] in the [file-in-relative-path] 


- fg [symbol] -- find [symbol] in *.gn and *.gni file

The commands listed above: some are alias commands and some are original defined name in shell-script.



### 4.2 Used in VS-Code

vs-code has also integrated the shell-env, so you can run the fastfind in that env. But don't forget to choose the right shell-env which fastfind fits.

vs-code supply a candy: **[Ctrl + mouse left-click]** on fastfind's result will quick jump to the line where the target locates.

Hint like this:

![image-20240603181122396](readme.pic/image-20240603181122396.png)

Enjoy it!~~

<br />



## 5. [Something help you work more fluently]

### 5.1 Shortcuts

you can ignore the shortcuts listed here, but if you are familiar with shortcuts, you can work more fluently. 

| vs-code command ID                       |
| ---------------------------------------- |
| copyRelativeFilePath                     |
| workbench.action.terminal.toggleTerminal |
| (more to be added.....)                  |

the specific shortcuts depend on the platform you used or the configuration set by you

### 5.2 VS-Code Setting(for User)

```json
    "terminal.integrated.commandsToSkipShell": [
      "workbench.action.quickSwitchWindow",
      "workbench.action.closeSidebar",
      "workbench.action.quickOpenView",
      "workbench.action.gotoSymbol",
      "workbench.action.showAllSymbols"
    ],
    "terminal.integrated.rightClickBehavior": "paste",
    "terminal.integrated.copyOnSelection": true,
    "terminal.integrated.wordSeparators": "()[]{} ',\"`─‘’|<>.:-;/\\&*-~=",
```

you can just copy these JSON fregments to the user setting.json of vs-code

<br />

## 6. [What's you need to know]

Now, the tool is designed basing on the C++ code style similar to WebRTC, if in other code style, you can try it....

<br />

## 7. [Something about  Design] -- TL;DR

The FastFind is based on the regular expression, not C++ syntax. Although there is few basic C++ syntax analysis included, but that's only for  fast implementation.

### 7.1 About the List

There are several list used by the fastfind. As mentioned above, "ffse-init" will prepare all the list except for ignore.list. Here is some explanation on these list:

- **all-src.list** -- all source files of C++ code used to find the symbol you want. It includes all the *.h file and *.cc. But the source file in the directory of "third_party" is not included, because that's not the core source of webrtc. Anyway, you can modify the shell-script to let ffse-init to include the source file in "third_party"
- **all-header.list** -- you can ignore this list, it's a historical left
- **all-gn.list** -- all the *.gn and *.gni file used for "fg" command
- **ignore.list** -- For some historical reason, not all the source files are used for  the current WebRTC version. For example: jitter_buffer.h and jitter_buffer.cc is obsoleted in the M97, so when we do the code analysis, we need sweep the distraction item, and our focus right and precise as possible as we can.

### 7.2 About command name

The command names are designed to as short as possible. If there is any name confliction, you can redefine it as you want

### 7.3 Something internal

"fs" will exclude the comments starts from "//" as the same to "fc"，but "ff" does not act like that. Maybe "ff" will support that in the future. The comments between "/* */" is not excluded, because it's not the main comments style in WebRTC code.

For the current version of FastFind(v3), its implementation is based on git-grep which has a domain-belonged shown in the result. It can help to know  which function the result locates in. That is similar to the visual assistant on Windows. Anyway, a few part of the domain-belonged is not what you are repect, but that will not confuse you. As you use it more and more, you will find that mis-match can be ignored

### 7.4 Command Parameters

You can use the command without any parameter, and that manner will help you to find most of what you want.

When you use "fs" or "fc", the parameter of "-pm" will give some helpful info. "-pm" means "partial match". But I don't use this parameter very often. The basic command form shown in Chapter-4 can meets most of my find. 

Yes, there are many other parameters in the tool now. But them will be revealed later, because, you know, WTFD is real a time-job. 



### 7.x MORE TO BE ADDED.....

For more info, please refer to the tool's shell script.
