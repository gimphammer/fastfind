# FastFind
## 1. [Screenshot]

![image-20240603172210739](readme.pic/image-20240603172210739.png)

![image-20240603172508178](readme.pic/image-20240603172508178.png)

![image-20240603174233244](readme.pic/image-20240603174233244.png)

Have a fun!~~​ :boom: :smiling_imp:

<br />

## 2. [Background]

It's a tool designed for C++ symbol search based on shell. 

It works under:

- git-bash shell on Windows 
- zsh on Mac.

Maybe it can fit other shell-env, but not test is performed

The idea of this tools comes from the terrible experience in using vs-code on WebRTC source code. There is no symbol colorful highlight, and no category in search result in vs-code. There are always so many results when search, so that you need to take too much time to find the focus you really care about.  And also on Mac, the IntelliSense and C++ extension does not work well as you expect, the performance on Mac can not be endured. 

This tool is designed to show respect to the visual assist which is the powerful extension of visual studio for C++ on Windows.

You can use command "ffse-help" to get some help. 

For historical reason, there are something named with "ffse" in the shell script, which stands for "fast-find-symbol-extension", and now it's the 3rd version, so you can find something with the name "FF3_XXX" or "FFSE" in the shell script. Don't be surprised when you see those names.......

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

"ffse-init" will prepare all the source file lists, used by FastFind, except for the "ignore.list". "ignore.list" is a list customized by your self. Refer to chapter 7.1 in this readme for more info on "ignore.list". You can also use the "ignore.list" in the directory of [ref_list](https://github.com/gimphammer/fastfind/tree/master/ref_list), if you are working with the M97 of WebRTC. And put it under the WebRTC root directory like this:

![image-20240604131613818](readme.pic/image-20240604131613818.png)

<br />

## 4. [Command usage]

### 4.1 Basic Command

- fc [symbol]  -- to find where the symbol is used, or the function is called

- fs [symbol] -- find all symbol in code base, not only where it is used, but also where it is defined. it can be function name, or var-name

- fdd [class-name] -- find all the class derived from the class named by [class-name], 

- fdc [class-name] -- find who is the father class for  [class-name]

- ff [symbol]  [file-in-relative-path] -- find all the symbol named by [symbol] in the [file-in-relative-path] 

- fg [symbol] -- find [symbol] in *.gn and *.gni file.  use this command to find something and analyze the WebRTC make-system

The commands listed above: some are alias commands and some are original defined name in shell-script.

Many of the commands include filters internal, to filter something it does not care about to make the result as concise as possible. In most of the using case, we wanna find where the function is called, or where the variance is used, to achieve that, we need to filter the C++ domain symbol, comments, And "fc" is the one who includes most filter, 

Only "ff" is search the file you set at at command parameter, and other commands search the list initialized by "ffse-init".

"fdd" and "fdc" is usually used to analyze the hierarchy of class. Sometime they get the same result.

"fs" has the fewest filter. If you can not find what you want by "fc", you can try "fs". We someting

"fg" is command like the "fs", but only works on all the gn stuff



### 4.2 Used in VS-Code

vs-code has also integrated the shell-env, so you can run the FastFind in that env. But don't forget to choose the right shell-env which FastFind fits.

vs-code supply a candy: **[Ctrl + mouse left-click]** on FastFind's result will quick jump to the line where the target locates.

Hint like this:

![image-20240603181122396](readme.pic/image-20240603181122396.png)

Enjoy it!~~

<br />



## 5. [Something help you work more efficiently]

### 5.1 Shortcuts

you can ignore the shortcuts listed here, but if you are familiar with shortcuts, you can work more fluently. The specific key-maps are not listed here. You can have your own setting according to your personal preference.

| vs-code command ID                       | Comments                                                     |
| ---------------------------------------- | ------------------------------------------------------------ |
| copyRelativeFilePath                     | Get related file path, used in the "ff" command              |
| workbench.action.terminal.toggleTerminal | To help you get a larger view of your editor zone, or active the terminal view when you wanna use FastFind |
| (more to be added.....)                  |                                                              |

the specific shortcuts depend on the platform you used or the configuration set by you

### 5.2 VS-Code Setting(User-Level)

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



### 5.3 Combined with "grep"

Sometime, there are some results which are not the ones you wanna focus on. If you wanna exclude them, then you can concatenate FastFind with `grep` by the pipe. Here comes the the example. Before concatenation:

![image-20240610203507258](readme.pic/image-20240610203507258.png)

After being concatenated with `gvi`, the lines containing "example" is excluded:

![image-20240610203619327](readme.pic/image-20240610203619327.png)

`gvi` is one of aliased `grep` commands I used. Here are some aliases I used frequently:

```bash
alias gp='grep '
alias gi='grep -i '
alias gv='grep -v '
alias gvi='grep -vi'
alias giv=gvi
alias gw='grep -w '
alias gnw='grep -nw'
alias gwn=gnw
#gh: '-H' is useful when use grep [on a single file] in vscode
#      it makes the result prefixed with filename and relative path
#      so you can jump to file-line with "ctrl+left click"
alias gf='grep -nwH'   #gf means grep in one file...

```

So, that is an example on how to exclude the result with `grep`. 

At other time, there is a large amount of results found by FastFind, but only a few of them is what you are interesting in. Then you can also extract those from the FastFind's result by `grep`. For example, if you only need the result related to "p2p" directory, then try it like this:

![image-20240610205414775](readme.pic/image-20240610205414775.png)

The `gi` is also an alias given above. 

Don't be surprised when you see the purple color of file is disappeared. If you are interesting in the tool, you will find the reason soon, and that's not a big deal we need to care about......



<br />

## 6. [What's you need to know]

Now, the tool is designed basing on the C++ code style similar to WebRTC, if in other code style, you can try it. Don't forget to modify the shell-function `if_in_webrtc_src_dir`，just `return 1` directly when enter the function：

```shell
function if_in_webrtc_src_dir() {

  #temp code for other code-base，
  #return true directly
  return 1


  local cur_path=$PWD

  if [ ! -d "${cur_path}/api" ]; then
    echo "[command meets error]:"
    echo "    not in the directory: \${webrtc_root}/src !!!"
    echo "    current dir is \"${cur_path}\", make sure you are under \${webrtc_root}/src "
    echo "    this error will terminate the command......"
    return 0
  fi

  return 1
}

```





<br />

## 7. [Something about  Design] -- TL;DR

### 7.1 Why FastFind Happened

the IDE has the features on code analysis, such as search, find defined, find reference, etc. On many scenarios these feature  work well, especially on the code base which is not big, but that dose not always happen on WebRTC. Maybe you can reduce the project included in to narrow the search scope, for example, just focus on the VCM module by open the only several projects. But the limits will follow that operation immediately.....

At first, I solve that problem by the `find` ,`grep` and other command. But every time, I have to type a lot of words.  And another issue that drive me crazy is the long time I need to wait to perform the these commands due to the huge amount `find` I/O and `grep` process. WebRTC is too huge, there are about 1-million files on the code base, but what I need is C++ source file which is only a small part of it, and also not all the C++ source files are what I need.....Actually, only about 4700 files are the ones I am interesting in, which is the core source of WebRTC excluding the third_party.

To always search in such a huge code base is not  the right way to do the right thing. Yes, It s*cks. What I want is just copying some keyword, and selecting the find-mode, then letting some guy do the left for me. What's more, a colorful highlight should be presented in the result, because that can help me focus on what I need. Then the FastFind happened to the world...

The FastFind is based on the regular expression, not C++ syntax. Although there is few basic C++ syntax analysis included, but that's only for  fast implementation. 

### 7.2 About the List

There are several list used by the FastFind. As mentioned above, "ffse-init" will prepare all the lists except for ignore.list. Here is some explanation on these list:

- **all-src.list** -- all source files of C++ code used to find the symbol you want. It includes all the *.h file and *.cc. But the source file in the directory of "third_party" is not included, because that's not the core party of WebRTC. Anyway, you can modify the shell-script to let ffse-init to include the source files in "third_party"
- **all-header.list** -- you can ignore this list, it's a historical left
- **all-gn.list** -- all the *.gn and *.gni file used for "fg" command
- **ignore.list** -- For some historical reason, not all the source files are used for  the current WebRTC version. All those files are listed in `ignore.list`. For example: jitter_buffer.h and jitter_buffer.cc is obsoleted in the M97, so when we do the code analysis, we need to sweep the distraction, and make our focus right and precise as possible as we can.

### 7.3 About Command Name

The command names are designed to as short as possible. If there is any name confliction, you can redefine or re-alias it as you want

### 7.4 Something Internal

"fs" will exclude the comments starts from "//" as the same to "fc"，but "ff" does not act like that. Maybe "ff" will support that in the future. The comments between "/* */" is not excluded, because it's not the main comments style in WebRTC code.

For the current version of FastFind(v3), its implementation is based on git-grep which has a domain-belonged shown in the result. It can help to know  which function the result locates in. That is similar to the visual assistant on Windows. Anyway, a few part of the domain-belonged is not what you are repect, but that will not confuse you. As you use it more and more, you will find that mis-match can be ignored

### 7.5 Command Parameters

You can use the command without any parameter, and that manner will help you to find most of what you want.

When you use "fs" or "fc", the parameter of "-pm" will give some helpful info. "-pm" means "partial match". But I don't use this parameter very often. The basic command form shown in Chapter-4 can meets most of my find. 

Yes, there are many other parameters in the tool now. But them will be revealed later, because, you know, WTFD is real a time-job. 

### 7.5 About the Colorful Highlight

That's the job the `ffse-init` does. Search the shell script, you will find that:

```shell
  git config --global color.grep.linenumber green
  git config --global color.grep.match      "brightyellow 241"
  git config --global color.grep.filename   magenta
  git config --global color.grep.function   214
  git config --global color.grep.matchContext  214    #white
```

You have saw many screen-shots in the previous chapters, and those colorful highlights are controlled by the `git config` list above. The value of the color is related to [ANSI escape code](https://en.wikipedia.org/wiki/ANSI_escape_code), you can have you own color setting if you are interesting in this topic.



### 7.x MORE TO BE ADDED.....

Please refer to the tool's shell script for more information.

<BR />



