# fastfind
## [Background]

It's a tool designed for C++ symbol find based on shell. It works under git-bash shell of windows and zsh on mac. 

The idea of this tools comes from the terrible experience in using vs-code on WebRTC source code. There is no symbol colorful highlight, and no category in search result on vs-code. There always so many results when use search, so that you need to take so many time to find the focus in the search result.  And also on Mac, the IntelliSense and C++ extension does not work well as you expect, the performance on Mac can not be endured. 

This tool is designed to show respect to the visual assist which is the powerful extension of visual studio for C++ on Windows.

fastfind use all-src.list to identify the files you need. Because not all file is needed, you can use command "ffse-help" to get some help. For historic reason, fastfind used the name of "ffse" which means "fast-find-symbol extension", and now it's the third version, so you can find something with the name "FF3_XXX" or "FFSE" in the shell script.......



## [Tool Init]

To init the tool, just:

1. put the ".fast_symbol_finder3.sh" in your home directory. To get your home directory, you can use:

```shell
#on windows 
echo %USERPROFILE%

#on mac
echo $HOME
```

2. then go to the webrtc directory, not the "src" directory, go the father directory of "src"

3. run the init command:

```shell
ffse-init
```



## [Basic usage]

fc "symbol"  -- to find where the symbol is used, or the function is called

fs [symbol] -- find all symbol in code base

fdd [class-name] find all the class derived from the class named by [class-name]

fdc [class-name] find who is the father class for  [class-name]

ff [symbol]  [file-in-relative-path] -- find all the symbol named by [symbol] in the [file-in-relative-path] 



## [What's you need to know]

Now, the tool is designed basing on the C++ code style similar to WebRTC, if in other code style, you can try it....



## [What's more]

For more info, please ref to the tool's shell script



Have a fun!~~
