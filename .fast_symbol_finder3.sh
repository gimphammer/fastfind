FF3_VERSION="v3.2.3"
FF3_COMMIT_DATE="07.02.2020"
FF3_HEADER_LIST="all-headers.list"
FF3_SRC_LIST="all-src.list"
FF3_IGNORE_LIST="ignore.list"  #for src and header finding
FF3_GN_LIST="all-gn.list"
FF3_MODE_HEADER='C/C++ Header Mode'
FF3_MODE_SRC='C/C++ Src Mode'
FF3_MODE_GN='GN Mode'
#FF3_GREP_CMD='grep'
FF3_GREP_CMD='git grep '
FFSE_PLATFORM_NAME=$(uname)
FFSE_READ_ARRAY_PARAM=""
FF3_USE_CURRENT_AS_LIST_DIR=1 #1表示，用当前目录为list文件的存放目录。0表示，用webrtc原生的src目录为list存放目录 

##############  History  ###########
#### v3.2.4 @02.13.2026 allow not in dir: webrtc/src
#### v3.2.3 @07.02.2020
#### - exclude "forward declaration" when call "fdd [classname]"
####
#### v3.2.2 @06.30.2020
#### - fix bug: exclude FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION in mac-zsh does not work.
####
#### v3.2.1 @06.26.2020
#### - support to add filter files when perform search by "-if"
####   it's an implementary way to fix-ignore-list
####
#### v3.2 @06.22.2020
#### - replace all file-exclude-pattern by git-grep's style
#### - set partial-match as the default style
####   to make the blance for format and search-result 
####
#### v3.1.1 @06.15.2020
#### - add "-id" to support to control domain symbole find with keyword for "fc"
####   Ex.> compare:
####        fc IsSimulcast
####        fc IsSimulcast -id
####
#### v3.1 @06.11.2020
#### - fix bug for fd/ff
#### - add new param of "-nf" to disable show of funciton name
#### - refine code-routine for comment-key filter to prevent
####   filtering line contain comment-key located after code
####   we need
#### - fix bug for ffse-init
####
#### v3.0 @06.09.2020
#### - add support to git-grep to show function name
####   where the keyword lies in
####
#### v2.0 @01.12.2020
#### - reconstruct framework to add supprt easily for all
####   kinds of documents. Now, only support to c/c++ file 
####   and gn is added
####
#### v1.7.3 @10.05.2019
#### - add support to colorful keyword listing with
####   ANSI-Escape-Code style
####
#### v1.7.2 @09.26.2019
#### - add support to don't match whole word. 
#### - refine grep param code-routine
####
#### v1.7.1 @09.02.2019
#### - remove obsoloted fastfind, only keep ffse
#### - combine mac-ffse and win-ffse to one shell script
#### - refine function naming, and clean some unused script
####
#### v1.7 @07.20.2019
#### - add support to filter ANSI-Escape-Code with "//"
#### - remove support to internal-exclude to avoid conflict 
####   to ANSI-Escape-Code with "//"
#### - refine naming of variable
####
#### v1.6 @07.13.2019
#### - add support to remove declaration of function
#### - refine ffse_example
####
#### v1.5.1 @07.10.2019
#### - add support to active debug mode by command param "-d"
####
#### v1.5 @07.09.2019
#### - add support to extra param, such as "-l"
#### - add support to FF3_EXCLUSIVE_PATTERN_FOR_WEBRTC_LOG
#### - refine debug info: dbg_cmd_recoder
####
#### v1.4 @06.07.2019
#### - add support to "-ne"
#### - remove param limit
#### - fix issue on mac grep: fit to grep-3.0+ on Mac. 
####   The support to grep-2.8 is obsoleted
####
#### v1.3 @05.22.2019
#### - add debug info
#### - add ffse_example
#### - add support to generate/updatae target-list 
#### - add check for webrt-src-dir
#### - add fastfindgn
####
#### v1.2 @05.16.2019
#### - refine pattern for webrtc-mac and webrtc-win
#### - refine check for exist of file-list
#### 
#### v1.1 @05.11.2019
#### - add ffse
#### - add ignore-file list
#### - add help info command
#### - refine support to filter
####
#### v1.0 @05.06.2019
#### - init version
####

########## known issue ##########
####
#### - issue case: ff "[this]"
####     keywords is "[this]", if quote in that form, the result is surprisingly
####     about "h".....
####     The reason is: it's related to the "eval" used internal in the ffse. If
####     call grep manually without eval. it works well. But we need "eval" now.
####     So, the solution is to use the form "\\\[this\\\]", and it's not convenient
####     Maybe better solution will be found later.....
####      
#### - to optimize:
####   to add a new exclusive pattern for "fdf"
####   to name a separated exclusive pattern for "fdc"
####   to name a separated exclusive pattern for "fdd"
####   so that, we can control the different find easily....
####


if [[ "$FFSE_PLATFORM_NAME" == *MINGW64* ]]; then  ####for win git bash
FFSE_READ_ARRAY_PARAM='-a'

FF3_INCLUDE_HEADER_REGEX=".*\.h\|.*\.hpp"
FF3_INCLUDE_FILE_REGEX='.*\.h\|.*\.hpp\|.*\.c\|.*\.cc\|.*\.cpp'
FF3_EXCLUDE_FILE_REGEX='.*unittest.*\|.*test.*\|.*mock.*\|.*mac\..*'
alias find-all-target-file='find . -type f -regex "$FF3_INCLUDE_FILE_REGEX" \
-not -regex "$FF3_EXCLUDE_FILE_REGEX" \
-not -path "*third_party*"  \
-not -path "*/tools/*"      \
-not -path "*/buildtools/*" \
-not -path "*test*"    \
-not -path "*/.git/*"  \
-not -path "*/out/*"   \
-not -path "*android*" \
-not -path "*mock*"    \
-not -path "*/objc/*"  \
-not -path "*/mac/*"   \
| sort '

alias find-all-target-header='find . -type f -regex "$FF3_INCLUDE_HEADER_REGEX" \
-not -regex "$FF3_EXCLUDE_FILE_REGEX" \
-not -path "*third_party*"  \
-not -path "*/tools/*"      \
-not -path "*/buildtools/*" \
-not -path "*test*"    \
-not -path "*/.git/*"  \
-not -path "*/out/*"   \
-not -path "*android*" \
-not -path "*mock*"    \
-not -path "*/objc/*"  \
-not -path "*/mac/*"   \
| sort '

alias find-all-gn-files='find . -type f -regex ".*\.gn\|.*\.gni" | sort '

########################   win git-bash filter   ########################
FF3_EXCLUSIVE_PATTERN_FOR_WEBRTC_LOG="RTC_LOG\|RTC_DLOG\|TRACE_EVENT0\|RTC_DCHECK\|<<"
####FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION
#   use this pattern to exlucd declaration and definition, 
#   that means only call to function is left
#   this is only for function decl, not class decl
#
#   "RTCError" is easy to over-exclude, so don't add it to global-pattern
#   ATTENTION:
#       to filter "int" alone, need to form as "\bint\b"
#   TestCase: fc OnNetworkAvailability
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION='\bclass\b'         # class
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bvirtual\b'    # virtual
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bexplicit\b'   # explicit
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bvoid\b'       # void
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bbool\b'       # bool
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bint\b'        # int
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bdelete;\b'    # delete;
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\boverride\b'   # override
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bbdefault;\b'  # bdefault;
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bNetworkControlUpdate\b'   # NetworkControlUpdate
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\bABSL_MUST_USE_RESULT\b'   # ABSL_MUST_USE_RESULT
#FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\|\b\b'   #


echo "[FFSE v$FF3_VERSION loaded]: win git-bash env is found"

elif [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then   ####for mac zsh
FFSE_READ_ARRAY_PARAM='-A'   #https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html

FF3_INCLUDE_HEADER_REGEX='.*\.(h$|hpp$)'
FF3_INCLUDE_FILE_REGEX='(.*\.(h$|hpp$))|(.*\.(cc$|cpp$|c$|m$|mm$))'
FF3_EXCLUDE_FILE_REGEX='.*(unittest|test|mock).*'
alias find-all-target-file='find -E . -regex "$FF3_INCLUDE_FILE_REGEX" \
-not -regex "$FF3_EXCLUDE_FILE_REGEX" \
-not -path "*third_party*"  \
-not -path "*/tools/*"      \
-not -path "*/buildtools/*" \
-not -path "*test*"    \
-not -path "*/.git/*"  \
-not -path "*/out/*"   \
-not -path "*android*" \
-not -path "*mock*"    \
| sort '
#-not -path "*/objc/*" '

alias find-all-target-header='find -E . -regex "$FF3_INCLUDE_HEADER_REGEX" \
-not -regex "$FF3_EXCLUDE_FILE_REGEX" \
-not -path "*third_party*"  \
-not -path "*/tools/*"      \
-not -path "*/buildtools/*" \
-not -path "*test*"    \
-not -path "*/.git/*"  \
-not -path "*/out/*"   \
-not -path "*android*" \
-not -path "*mock*"    \
| sort '
#-not -path "*/objc/*" '


alias find-all-gn-files='find -E . -regex ".*\.gn|.*\.gni" | sort '

########################   mac-zsh filter   ########################
FF3_EXCLUSIVE_PATTERN_FOR_WEBRTC_LOG="RTC_LOG\|RTC_DLOG\|TRACE_EVENT0\|RTC_DCHECK\|<<"
####FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION
#   use this pattern to exlucd declaration and definition, 
#   that means only call to function is left
#   this is only for function decl, not class decl
#
#   "RTCError" is easy to over-exclude, so don't add it to global-pattern
#   TestCase: fc OnNetworkAvailability 
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION='\\bclass\\b'         # class
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bvirtual\\b'   # virtual
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bexplicit\\b'  # explicit
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bvoid\\b'      # void
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bbool\\b'      # bool
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bint\\b'       # int
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bdelete;\\b'   # delete;
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\boverride\\b'  # override
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bdefault;\\b'  # default;
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bNetworkControlUpdate\\b' # NetworkControlUpdate
FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\bABSL_MUST_USE_RESULT\\b' # ABSL_MUST_USE_RESULT
#FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION+='\\|\\b\\b'


echo "[FFSE v$FF3_VERSION loaded]: mac shell env is found"

else	#### error case
  echo "[ERROR v2]ffse init error, platform is not supported: $FFSE_PLATFORM_NAME"
fi


function ffse-help() {
  echo "  ffse tool-set v$FF3_VERSION by Jonathon@$FF3_COMMIT_DATE"
  echo "  "
  echo "  [Background]"
  echo "  1. \"ffse\" is a set of shell-tool to perform keyword-search, and It's based on grep."
  echo "     The \"ffse\" is used to accelarate the symbol-find with color decoration on webrtc"
  echo "     code, and this idea is triggered by the terrible experience on symbol-find in"
  echo "     vs-code. So, the default \"ffse\" work directory is: \${webrtc_root}/src"  
  echo "  "
  echo "  2. \"ffse\" includes these commands:"
  echo "       ffse-init"
  echo "       ffse"
  echo "       ffse-example"
  echo "  "
  echo "  3. \"ffse-init\" is a command to init the file-list used for ffse search."
  echo "     This command does not need any parameter. it will judge if you are in the right "
  echo "     directory: \${webrtc_root}/src. If you are in the wrong directory, error will be "
  echo "     shown. If you have more than one codebase of webrc, you can init ffse seperately,"
  echo "     the only thing you need to care about is to init \"ffse\" on the this direcory:"
  echo "         \${webrtc_root}/src"
  echo "     After init, you can use the \"ffse\" comand in system shell, or in vs-code shell env."
  echo "     For windows, git bash is recommended. and you can choose it in vs-code terminal."
  echo "     vs-code terminal enables you clicking on the search result to jump to the target "
  echo "     line in src-file quickly, which is an useful feature."
  echo " "
  echo "  4. You can also apply \"ffse\" to other large codebase and other lanuage after some"
  echo "     modification."
  echo " "
  echo "  5. call command of \"ffse_example\" to get more info of usage"
  echo " "
  echo "  [Command Categories]"
  echo "    call ffse-cmd-list for more info"
  echo "  "
  echo "  [Parameter Categories]"
  echo "  There are several categories of the parameter, listed below:"
  echo "  1. format control  -- TODO: list all"
  echo "  2. search control  -- TODO: list all"
  echo "  "
  echo "  [Prerequisite]"  
  echo "     GNU grep 3.0+ is required"
  echo "  "
  echo "  [TL;DR]"
  echo "     The best tool I have used for code parsing on large codebase is Visual Assist, but "
  echo "     unfortunately, it only works on Windows. On MacOS, xcode is definitely the basic IDE,"
  echo "     but it still has something I can't tell...Althought the combination of cscope/ctags/vim"
  echo "     is tried, it's still not efficient enough for large codebase. And some other tools are"
  echo "     also tried and used for a long time, cross-platform and efficience on large codebase"
  echo "     can not be satisfied to me both. Maybe I don't try enough..."
  echo "     Until vs code is published, I feel that I can do something...Then here is the \"ffse\"."
  echo "     "
  echo "     Because of basing on grep, not the language syntax parser, so the ffse is not perfect,"
  echo "     but it can accelearte the job -- That's also the primal idea of \"ffse\". "
  echo "     Also, the performance of \"ffse\" can be optimized by added the \"filter\" according"
  echo "     to what you want. Now, it has these exclusive-filter(EF):"
  echo "       1. basic EF of comments symbol - // "
  echo "       2. EF of log-code"
  echo "       3. EF of declaration"
  echo "     You can abstract new EF concept add extend it one by one in your daily use"
  echo " "
  echo "     \"ffse\" is initialized in C/C++ code parsing, but not limited in C/C++. That's the "
  echo "     benefit by grep."
}


########################################################################
#######################   for file-list update   #######################
########################################################################
function if_in_webrtc_src_dir() {
  #FF3_USE_CURRENT_AS_LIST_DIR=1，允许不在webrtc/src目录下
  if [ $FF3_USE_CURRENT_AS_LIST_DIR -eq 1 ]; then
    return 0
  fi

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

# if_file_exists [file]
function if_file_exists() {
  if [ ! -e $1 ]; then
    echo "[command meets error]:"
    echo "    Check if target-list exist: $1 "
    echo "    If there are no these list-file, you can use command \"ffse-init\""
    echo "    to generate the list file. Call \"ffse-help\" for more info."
    echo "    this error will terminate command ......"
    return 0;
  fi

  return 1
}

function ffse-init() {
  git config --global color.grep.linenumber green
  git config --global color.grep.match      "brightyellow 241"
  git config --global color.grep.filename   magenta
  git config --global color.grep.function   214
  git config --global color.grep.matchContext  214    #white
  echo "git-grep color setting is done..."

  #增加提示：
  # 打印USE_TARGET_ROOT_DIR的值，并提示是否修改
  echo -e "FF3_USE_CURRENT_AS_LIST_DIR=${FF3_USE_CURRENT_AS_LIST_DIR}"
  echo -e "usage: if FF3_USE_CURRENT_AS_LIST_DIR=1, the current directory is used as the list-saving dir."
  echo -e "       otherwize, you should in directory: \"webrtc/src\" "
  echo -e "       Are you sure to continule? (\"y\" for continue, any other input to abort)"

  # 获取键盘输入
  if [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then
    # Zsh 中使用 -k 参数
    read -k 1 key
  else
      # Bash/Git Bash 中使用 -n 1 参数
    read -n 1 key
  fi
  # 没输入enter键，则终止执行
  if [ -n "$key" ] && [ "$key" != $'y' ]; then
    echo "aborted by user!"
    exit 1
  else
    echo -e "\ncontinue to process......"
  fi

  if_in_webrtc_src_dir
  ret=$?
  if [ "$ret" -eq 0 ]  && [ "$FF3_USE_CURRENT_AS_LIST_DIR" -ne 1 ]; then
    echo "Aborted, FF3_USE_CURRENT_AS_LIST_DIR=${FF3_USE_CURRENT_AS_LIST_DIR}, "
    echo "and you are not in dir: webrtc/src"
    exit 1
    # return  #error case
  fi

  local cur_path=$PWD
  local list_file_root=""
  if [ "$FF3_USE_CURRENT_AS_LIST_DIR" -eq 1 ]; then
    list_file_root="${PWD}"
  else
    list_file_root="${PWD}/.."
  fi
  
  local header_list="${list_file_root}/${FF3_HEADER_LIST}"
  if [ -e "$header_list" ];then
    rm ${header_list}
  fi
  find-all-target-header > ${header_list}
  echo "header list has been updated: ${header_list}"


  local srcs_list="${list_file_root}/${FF3_SRC_LIST}"
  if [ -e "${srcs_list}" ];then
    rm ${srcs_list}
  fi

  find-all-target-file > ${srcs_list}
  echo "source list has been updated: ${srcs_list}"


  local gn_list="${list_file_root}/${FF3_GN_LIST}"
  if [ -e "${gn_list}" ];then
    rm ${gn_list}
  fi
  find-all-gn-files > ${gn_list}
  echo "gn list has been updated: ${gn_list}"
  echo ""
  echo -e "all init is done!\n"
}



function ffse-show-basic-info() {
  echo "Version: $FF3_VERSION by Jonathon @$FF3_COMMIT_DATE (git-grep is required)"
  echo 'Call "ffse_example" to get more examples of usage'
  echo -e  

  echo "find symbole based on: $1"
}


##
# fastsymbolfindercore <1.mode> [2.target-files.list] <3.ignore-files.list>
#                      [4.include-key] <5.comments_pattern_to_exclude> 
#                      <6.exclusive_patern> <7.exclusive_note> <8.parameter>
#                       
# 可能为空的参数: <mode>, <ignore.list>, <comments-symbol>, <exclude-key>
#
function fast_symbol_finder_core() {
  if_in_webrtc_src_dir
  ret=$?
  if [ $ret -eq 0 ] && [ $FF3_USE_CURRENT_AS_LIST_DIR -ne 1 ]; then
      return
  fi

  local mode="$1"
  local target_list="$2"
  local ignore_list="$3"
  local include_key="$4"
  local comments_key="$5"
  local exclude_pattern="$6"
  local exclude_note="$7"

  ffse_get_array_start_idx
  local array_start_idx=$?  #start idx is always fixed, as the platform is sest
  local array_end_idx    #end idx is decided by array-size, to be decided later

  shift $((6 + 1))  #shift 6 positions, to start from parametr

  # echo "---====Debug Info====---"
  # echo "Before shift, mode=$mode, target_list=$target_list"
  # echo "              ignore_file=$ignore_list"
  # echo "              include_key=$include_key, comments_key=$comments_key"
  # echo "              exclude_pattern=$exclude_pattern"
  # echo "              exclude_note=$exclude_note"

  # echo "After  shift, \$@=$@"

  if_file_exists "$target_list"
  ret=$?
  if [ $ret -eq 0 ]; then
    return
  fi  

  local param_cnt=$#
  local partial_match=0
  local only_list_file=0  # only file is list which contain the keyword
  local remove_log=1
  local remove_declaration=1
  local is_debug=0
  local plain_text=0  # not plain text, means need color and info
  local extra_grep_param=" "  #extra grep param passed to grep directly
  local show_function_name=1
  local remove_expanded_decl=0  #decl=declaration
  local rm_domain_symbol_with_match=0
  local file_name_heading_mode=0  #show file name above the match-result
  local clean_show=0
  local ignore_files_by_manual=()  #ignore files, send manually from command parameter...
  local break_lines=0
  local exclude_forward_declaration=0  

  for ((i=1; i<=param_cnt; i++)) do
    eval local this_param=\${$i}
    if [ "$this_param" = "-l" ]; then
      only_list_file=1
    elif [ "$this_param" = "-pm" ]; then  #"-pm" means partial match
      partial_match=1
    elif [ "$this_param" = "-rd" ]; then
      remove_declaration=1
    elif [ "$this_param" = "-il" ]; then
      remove_log=0
    elif [ "$this_param" = "-d" ]; then
      is_debug=1
    elif [ "$this_param" = "-pt" ]; then
      plain_text=1
    elif [ "$this_param" = "-cs" ]; then  #"-cs" means clean-show, no extra info shown
      clean_show=1
    elif [ "$this_param" = "-nf" ]; then  # -nf = "no git-grep context function name", to avoid it git-grep context function-name to be shown 
      show_function_name=0
    elif [ "$this_param" = "-ic" ]; then
      continue
    elif [ "$this_param" = "-il" ]; then
      continue
    elif [ "$this_param" = "-rd" ]; then #this parameter is obsoleted, will removed later...
      # rd = remove definiton 
      #Ex. "fc ProbeController", "ProbeController::" should be excluded from "ProbeController::Proces"
      #because ProbeController::Proces is not useful for search target code "ProbeController* probe"
      remove_expanded_decl=1
    elif [ "$this_param" = "-rs" ]; then 
      # -rs=remove static function for c++, the line contains "::IsSimulcast" 
      # from "VideoStreamEncoderResourceManager::IsSimulcast" will be removed
      # this is useful when "fc [class static method]
      # for "fc", the "-rs should be used as default, because for static function is only minor part"
      # "--force-include-domain-symbol is a param parsed on up-invoke leve"
      # remove static function will be translated to remove_domain_symbol_with_match
      # as default of the core-function, -rs should not be used, because we have "fs"
      rm_domain_symbol_with_match=1
    elif [ "$this_param" = "-hm" ]; then #am = above mode
      file_name_heading_mode=1
    elif [ "$this_param" = "-b" ]; then
      break_lines=1
    elif [ "$this_param" = "-efd" ]; then
      exclude_forward_declaration=1  # "class Thread;"  will be exclude when use "fdc Thread", it's forward declaration
    elif [[ $this_param == -if=* ]]; then #-if = ignore files
      # get the string after "-if="
      IFS=',' read -r $FFSE_READ_ARRAY_PARAM ignore_files_by_manual <<< "${this_param#*=}"
    else 
      extra_grep_param="$extra_grep_param $this_param"
    fi
  done


  local has_ignore_list=0
  local ignore_array=()
  if [ -e "$ignore_list" ]; then
    has_ignore_list=1
  fi

  if ! [ $plain_text -eq 1 ] && ! [ $clean_show -eq 1 ]; then 
    ffse-show-basic-info $target_list
    if [ $has_ignore_list -eq 1 ]; then
      echo -e "ignore list: $ignore_list \n"
    else
      echo -e "ignore list: <no ignore list>\n"
    fi
  fi


  ### process grep parameter
  local grep_param="-n"
  if [ $only_list_file -eq 1 ]; then
    grep_param="$grep_param -l"
  fi

  if [ $show_function_name -eq 1 ]; then
    grep_param="$grep_param -p"
  fi

  if [ $file_name_heading_mode -eq 1 ]; then
    grep_param="$grep_param --heading"
  fi

  if  [ $plain_text -ne 1 ]; then
    grep_param="$grep_param --color=always"
  else
    grep_param="$grep_param --color=never"
  fi

  if [ $break_lines -eq 1 ]; then
    grep_param="$grep_param --break"
  fi

  if [[ "$FFSE_PLATFORM_NAME" == *MINGW64* ]]; then  #for win git bash
    grep_param="$grep_param --threads=12 $extra_grep_param --no-index"
  elif [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then   #for mac zsh
    grep_param="$grep_param --threads=8 $extra_grep_param --no-index"
  else
    echo "[ERROR]platform not supported: $FFSE_PLATFORM_NAME"
    return;
  fi

  local pattern_to_process=""
  if [ $partial_match -eq 1  ]; then
    pattern_to_process="$pattern_to_process -e \"$include_key\""
  else
    #this is default:exactly match
    #but don't use "-w", because "-w" will affter the exclude "$include_key::"
    #according to git-grep rules...
    pattern_to_process="$pattern_to_process -e \"\b$include_key\b\""
  fi
  #pattern_to_process="$pattern_to_process --and --not  -E -e '\"[^"]*$include_key[^"]*\"'"

  if ! [ -z $comments_key ];then
    pattern_to_process="$pattern_to_process --and --not -e \"\s*$comments_key\""
  fi

  if ! [ -z $exclude_pattern ]; then
    pattern_to_process="$pattern_to_process --and --not -e \"$exclude_pattern\""
  fi

  ### this exclude does not work, need investigate......
  if [ $remove_declaration -eq 1 ]; then
    #remove dto of class, such as: ~ProbeBitrateEstimator()
    pattern_to_process="$pattern_to_process --and --not -e \"\b~$include_key\b\""
  fi

  if [ $rm_domain_symbol_with_match -eq 1 ];then
    #Example:: fc CreateVideoChannel, exclude "::CreateVideoChannel" and "CreateVideoChannel::"
    pattern_to_process="$pattern_to_process --and --not -e \"::$include_key\""
    pattern_to_process="$pattern_to_process --and --not -e \"$include_key::\""
    #Ex. fc "SetLocalDescription", should remove targert in quote-symbol:
    #   "SetLocalDescription failed because the session was shut down"));
    # pattern_to_process="$pattern_to_process --and --not -e '\"[^\"]*$include_key[^\"]*\"'"
    pattern_to_process="$pattern_to_process --and --not  -e '\"[^\"]*'"$include_key"'[^\"]*\"'"
  fi

  if [ $exclude_forward_declaration -eq 1 ];then
    pattern_to_process="$pattern_to_process --and --not -e \"$include_key;\""
  fi

  # for ignore-files in fixed ignore-list
  local exc_pattern=""
  if [ $has_ignore_list -eq 1 ]; then
    # cat -v <<< ffse_get_fep $ignore_list
    exc_pattern=$(ffse_get_fep $ignore_list)
    pattern_to_process="$pattern_to_process -- $exc_pattern"
  fi

  # for ignore-files input manually when search, NOT the fixed ignore-list
  if ! [ ${#ignore_files_by_manual[@]} -eq 0 ]; then
    exc_pattern=$(ffse_trans_to_fep ${ignore_files_by_manual[@]})
    pattern_to_process="$pattern_to_process -- $exc_pattern"
  fi

  # eval echo "----exc_pattern=$exc_pattern"

  ### final call
  local dbg_branch_id=0
  local dbg_cmd_recoder=-1
  cat $target_list | eval xargs $FF3_GREP_CMD $grep_param  $pattern_to_process | cat #$extra_cmd   
  dbg_cmd_recoder="cat $target_list | eval xargs $FF3_GREP_CMD $grep_param $pattern_to_process" #$extra_cmd 
  dbg_branch_id=1



  ### common info and debug info
  if ! [ "$plain_text" -eq 1 ] && ! [ $clean_show -eq 1 ]; then
    echo " "  #to add one-more line between result and extrainfo
    eval echo "include_key: $'\x1b[93m\x1b[K'$include_key$'\x1b[m'"
    eval echo "exclude_pattern: $'\x1b[01;31m\x1b[K'$exclude_note$'\x1b[m'"
  fi

  if [ $is_debug -eq 1 ];then
    echo " "
    echo "-----------========================== debug info ============================--------"
    echo "has_ignore_list : $has_ignore_list"
    echo "branch_id       : $dbg_branch_id"
    echo "need_to_exclude : $need_to_exclude"
    # if [ $need_to_exclude -eq 1 ];then
      echo "    comments_key : $comments_key"
      echo "    remove_log   : $remove_log"
      echo "    remove_declaration : $remove_declaration"      
      echo "    FF3_EXCLUSIVE_PATTERN_FOR_WEBRTC_LOG : $FF3_EXCLUSIVE_PATTERN_FOR_WEBRTC_LOG"
      echo "    FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION: $FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION"
      echo "    exclude_cmd : $exclude_cmd"
    # fi
    echo " "
    cat -v <<< "main_command : $dbg_cmd_recoder"
    echo ""
    eval echo "exc_pattern  : $exc_pattern"
    echo " "
    echo    "GREP_COLORS: $GREP_COLORS"
    echo    "xargs alias info: `alias xargs` "
    echo -e "FF3_GREP_CMD    : $FF3_GREP_CMD \n"
    # echo    "git-grep color config by manual:"
    # echo    "    linenumber:   $(git config --get color.grep.linenumber)"
    # echo    "    match:        $(git config --get color.grep.match)"
    # echo    "    filename:     $(git config --get color.grep.filename)"
    # echo    "    function:     $(git config --get color.grep.function)"
    # echo    "    matchContext: $(git config --get color.grep.matchContext)"
    echo "-----------==================================================================--------"
  fi
}



#fast_find_in_gn "video_send_stream.h" -d
function fast_find_in_gn() {
  local cur_path=`pwd`


  if [ "$FF3_USE_CURRENT_AS_LIST_DIR" -eq 1 ]; then
    list_file_root="${cur_path}"
  else
    list_file_root="${cur_path}/.."
  fi


  local target_list="${list_file_root}/$FF3_GN_LIST"
  local ignore_list=""
  local inclusive_key=$1

  shift #remove the include-key

  local include_comments=0
  local include_log=0
  local remove_declaration=0

  local comments_pattern_to_exclude="\#"
  local exclusive_patern=""
  local exclusive_note="\#"
  local params=()

  #-il, -rd is not meanful to gn-find
  local param_cnt=$#
  for ((i=1; i<=param_cnt; i++)) do
    eval local this_param=\${$i}
    if [ "$this_param" = "-ic" ]; then ##-ic - include comments
      include_comments=1
    elif [ "$this_param" = "-hm" ]; then
      params+=($this_param)
    fi
  done

  if [ $include_comments -eq 1 ]; then
    comments_pattern_to_exclude=""
    exclusive_note=""
  fi

  fast_symbol_finder_core "$FF3_MODE_GN" "$target_list" "$ignore_list" \
                          "$inclusive_key" "$comments_pattern_to_exclude" \
                          "$exclusive_patern" "$exclusive_note"  ${params[@]}
}


###
# fast_find_in_header is same to fast_find_in_c_and_cpp_source
# the only thing different is the target-list
function fast_find_in_header() {
  local cur_path=`pwd`
  local target_list="$cur_path/../$FF3_HEADER_LIST"
  local ignore_list="$cur_path/../$FF3_IGNORE_LIST"
  local inclusive_key=$1
  shift  #remove the inclusive-key

  local include_comments=0
  local include_log=0
  local remove_declaration=0

  local comments_pattern_to_exclude="//"
  local exclusive_patern=""
  local exclusive_note="//"

  #-ic,-il,-rd is pattern related param
  local param_cnt=$#
  for ((i=1; i<=param_cnt; i++)) do
    eval local this_param=\${$i}
    if [ "$this_param" = "-ic" ]; then ##-ic - include comments
      include_comments=1
    elif [ "$this_param" = "-il" ]; then
      include_log=1      
    elif [ "$this_param" = "-rd" ]; then
      remove_declaration=1
    fi
  done

  if [ $include_comments -eq 1 ]; then
    comments_pattern_to_exclude=""
    exclusive_note=""
  fi

  if [ $include_log -eq 0 ]; then
    exclusive_patern="$FF3_EXCLUSIVE_PATTERN_FOR_WEBRTC_LOG"
    exclusive_note=$(ffcs "$exclusive_note" ", " "\[log words...\]")
  fi

  if [ $remove_declaration -eq 1 ]; then
    exclusive_patern=$(ffcs "$exclusive_patern"  "\\|"  "$FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION")
    exclusive_note=$(ffcs "$exclusive_note" ", " "\[decl words...\]")
  fi

  fast_symbol_finder_core "$FF3_MODE_SRC" "$target_list" "$ignore_list" \
                          "$inclusive_key" "$comments_pattern_to_exclude" \
                          "$exclusive_patern" "$exclusive_note" $@\

}

#example: fast_find_in_c_and_cpp_source "OnRtpPacket" -d
function fast_find_in_c_and_cpp_source() {
  
  local cur_path=`pwd`
  local list_file_root=$cur_path

  
  if [ "$FF3_USE_CURRENT_AS_LIST_DIR" -ne 1 ]; then
    list_file_root="${cur_path}/.."
  fi



  local target_list="$list_file_root/$FF3_SRC_LIST"
  local ignore_list="$list_file_root/$FF3_IGNORE_LIST"
  local inclusive_key=$1
  shift  #remove the inclusive-key

  local include_comments=0
  local include_log=0
  local remove_declaration=0

  local comments_pattern_to_exclude="//"
  local exclusive_patern=""
  local exclusive_note="//"

  #-ic,-il,-rd is pattern related param
  local param_cnt=$#
  for ((i=1; i<=param_cnt; i++)) do
    eval local this_param=\${$i}
    if [ "$this_param" = "-ic" ]; then ##-ic - include comments
      include_comments=1
    elif [ "$this_param" = "-il" ]; then
      include_log=1      
    elif [ "$this_param" = "-rd" ]; then
      remove_declaration=1
    fi
  done

  if [ $include_comments -eq 1 ]; then
    comments_pattern_to_exclude=""
    exclusive_note=""
  fi

  if [ $include_log -eq 0 ]; then
    exclusive_patern="$FF3_EXCLUSIVE_PATTERN_FOR_WEBRTC_LOG"
    exclusive_note=$(ffcs "$exclusive_note" ", " "\[log words...\]")
  fi

  if [ $remove_declaration -eq 1 ]; then
    exclusive_patern=$(ffcs "$exclusive_patern"  "\\|"  "$FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION")
    exclusive_note=$(ffcs "$exclusive_note" ", " "\[decl words...\]")
  fi

  fast_symbol_finder_core "$FF3_MODE_SRC" "$target_list" "$ignore_list" \
                          "$inclusive_key" "$comments_pattern_to_exclude" \
                          "$exclusive_patern" "$exclusive_note" $@\
                          
}





#fsf_misc_cat_string $name "\|" $address
alias ffcs=fsf_misc_cat_string
function fsf_misc_cat_string() {
  local param_cnt=$#
  if [ $param_cnt -ne 3 ]; then
    echo "[ERROR]fsf_misc_cat_string: param count is $param_cnt, it needs three params"
    echo "                params set: $@"
    echo "command gonna be terminaled...."
    return 0
  fi

  local first_string="$1"
  local second_string="$2"
  local third_string="$3"
  local ret=""
  if [ -z "$1" ]; then
    echo "$third_string"  #bash shell return does not support string, need to echo, and caller do something
  else
    echo "$1$2$3"
  fi

  return 1
}

function ffse_read_file_to_array() {
  # 检查参数是否为空
  if [ $# -ne 1 ]; then
    echo "Usage: read_file_to_array <file>"
    return 1
  fi
  
  local file="$1"
  local line
  local array=()

  # 逐行读取文件内容，并存储到数组中
  while IFS= read -r line || [ -n "$line" ]; do
    array+=("$line")
  done < "$file"

  # 输出数组内容到标准输出
  printf '%s\n' "${array[@]}"
#  echo "------------------${array[1]}"
}

function ffse_is_numeric() {
    expr "$1" + 0 > /dev/null 2>&1
}


function ffse_get_array_start_idx() {
    if [[ "$FFSE_PLATFORM_NAME" == *MINGW64* ]]; then  #for win git bash
      return 0
    elif [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then   #for mac zsh
      return 1
    else
      echo "[ERROR][ffse_get_array_start_idx]platform not supported: $FFSE_PLATFORM_NAME"
      exit 1;
    fi
}

function ffse_get_array_end_idx() {
    local param_cnt=$#
    if [ "$param_cnt" -ne 1 ]; then
      echo "[ERROR][ffse_get_array_end_idx]make sure you send only one-parameter"
      exit 1
    fi

    if ! ffse_is_numeric "$1"; then
      echo "[ERROR][ffse_get_array_end_idx]make sure the param you send is number. this is your param: $1"
      exit 1
    fi

    local size=$1
    local end_idx=0
    if [[ "$FFSE_PLATFORM_NAME" == *MINGW64* ]]; then  #for win git bash
      #window git bash array:[0, size)
      end_idx=$((size))
    elif [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then   #for mac zsh
      #mac zsh array:[1, size+1)
      end_idx=$((size+1))
    else
      echo "[ERROR]ffse_get_array_end_idx platform not supported: $FFSE_PLATFORM_NAME"
      exit 1;
    fi

    # echo "end_idx=$end_idx"
    return $end_idx
}

### ffse_get_fep: it's for fixed ignore-list
###
alias ffse_get_fep=ffse_misc_get_file_exclude_pattern_from_list_for_git_grep
function ffse_misc_get_file_exclude_pattern_from_list_for_git_grep() {
  local ignore_list=$1
  local exc_pattern=""

  local ignore_array=()  #used by two code-routine branch in if/else

  if [[ "$FFSE_PLATFORM_NAME" == *MINGW64* ]]; then  #for win git bash
    readarray -t ignore_array < $ignore_list

    ffse_get_array_end_idx ${#ignore_array[@]}
    array_end_idx=$?
    for ((i=array_start_idx; i<array_end_idx; i++)); do
      exc_pattern="$exc_pattern :^${ignore_array[i]}"
    done

  elif [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then   #for mac zsh
    local temp_array=()  #only used in "Darwin" code-routine branch
    temp_array=($(ffse_read_file_to_array "$ignore_list"))

    ffse_get_array_end_idx "${#temp_array[@]}"
    array_end_idx=$?

    ##remove the empty line
    for ((i=array_start_idx; i<array_end_idx; i++)) do
      if ! [ -z $temp_array[i] ]; then
        ignore_array+=("$temp_array[i]")
      fi
    done

    ffse_get_array_end_idx ${#ignore_array[@]}
    array_end_idx=$?

    for ((i=array_start_idx; i<array_end_idx; i++)); do
      exc_pattern="$exc_pattern :^${ignore_array[i]}"
    done

    ### eval of mac zsh treat "*" as special-word, so changed to "\*"
    if [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then   
      exc_pattern=$(printf '%s' "$exc_pattern" | sed 's/\*/\\*/g')
    fi

  else
    echo "[ERROR]platform not supported: $FFSE_PLATFORM_NAME"
    return;
  fi

  echo "$exc_pattern"
}


###
###  ffse_trans_to_fep file1 file2 .....
###   it's only for manully use, when search..
###
alias ffse_trans_to_fep=ffse_misc_transform_to_file_exclude_pattern_from_files_for_git_grep
function ffse_misc_transform_to_file_exclude_pattern_from_files_for_git_grep() {
  local file_cnt=$#

  if [[ $file_cnt -eq 0 ]]; then
    return 1
  fi


  ffse_get_array_end_idx $file_cnt
  array_end_idx=$?

  local exc_pattern=""
  for ((i=1; i<=file_cnt; i++)); do
    eval local this_param=\${$i}
    exc_pattern="$exc_pattern :^**/$this_param"
  done

  if [[ "$FFSE_PLATFORM_NAME" == *MINGW64* ]]; then  #for win git bash
    :  #do nothing
  elif [ "$FFSE_PLATFORM_NAME" = "Darwin" ]; then   #for mac zsh
    ### eval of mac zsh treat "*" as special-word, so changed to "\*"
    exc_pattern=$(printf '%s' "$exc_pattern" | sed 's/\*/\\*/g')
  else
    echo "[ERROR]platform not supported: $FFSE_PLATFORM_NAME"
    exit 1;
  fi

  echo "$exc_pattern"
}


function fsf_test_cat_string(){
  local ret_string_1=$(ffcs "name" '\|' "address")
  local ret1=$?

  local ret_string_2=$(ffcs "" '\|' "address")
  local ret2=$?

  echo "test_cat_string, ret1=$ret1, ret_string_1=$ret_string_1"
  echo "test_cat_string, ret2=$ret2, ret_string_2=$ret_string_2"
}


function ff() {
  local param="-nwp"
  local keyword="$1"
  local file="$2"
  local param_cnt=$#
  if [ $param_cnt -lt 2 ]; then
    echo "ERROR: ff(Find in File) needs two parameters at least"
    exit 1
  fi

  shift
  shift

  param_cnt=$#
  local extra_param=()
  for ((i=1; i<=param_cnt; i++)) do
    eval local this_param=\${$i}
    if [ "$this_param" = "-hm" ];then
      extra_param+=("--heading")
    # elif [ "$this_param" = "-b" ];then
    #   extra_param+=("--break")
    fi
  done

  #--heading 
  eval $FF3_GREP_CMD --color=always -nwp ${extra_param[@]}  -e $keyword $file  | cat
  echo ""
}


function fc() {  #find call
  local keyword=$1
  shift

  #we can not concatenate the params with simple string-concatenate
  #we should use bash array when we need to concatenate the command param
  # "-hm": means "heading mode", list filename above match items
  local params=("-rd") #remove declaration is basic.
  local remove_domain_symbol=1
  local need_heading_mode=0

  local param_cnt=$#

  for ((i=1; i<=param_cnt; i++)) do
    eval local this_param=\${$i}
    #TODO:
    #demo line: pc/rtp_transport.cc:107:        this, &RtpTransport::OnNetworkRouteChanged);
    #-is: change explanation to "include domain symbol"
    #may be also, "-is" is better to be changed to "-id"
    if [ "$this_param" = "-is" ]; then  #here is=include static function format
      remove_domain_symbol=0
    elif [ "$this_param" = "-hm" ]; then
      #"-hm": means "heading mode", show file name above the match-result
      # it's sibling of "-hm"
      need_heading_mode=1
    else
      params+=("$this_param")
    fi
  done

  if [ $need_heading_mode -eq 1 ]; then
    params+=("-hm")
  fi

  if [ $remove_domain_symbol -eq 1 ]; then
    params+=("-rs")  #remove static function format is an extended param
  fi

  params+=("-cs")  #clean-show

  fast_find_in_c_and_cpp_source "$keyword" "${params[@]}"
}

function fdf() { #find definition of function 
  local keyword=$1
  shift 
  fast_find_in_c_and_cpp_source $keyword "-nf" $@  
}

function fdc() {  #find definiton for class/struct...
  local keyword=$1
  shift 
  fast_find_in_c_and_cpp_source $keyword "-nf" "-efd" $@ |  grep --color=never  -E "class|struct"
}

function fdd() {  #find definiton for derived class from "keyword"
  local keyword=$1
  shift 
  fast_find_in_c_and_cpp_source $keyword "-nf" $@ |  grep --color=never  -E "public|private"
}



function ffse-cmd-list() {
  echo    "ff  : find in single-file,   ff = 'grep -nwH '"
  echo    "fs  : find in source,        fs = fast_find_in_c_and_cpp_source"
  echo    "fh  : find in headers,       fh = fast_find_in_header"
  echo    "fg  : find in gn-files,      fg = fast_find_in_gn"
  echo    "fc  : find call"
  echo    "fdd : find definition on derivation relationship of class"
  echo -e "fdc : find definition for class, it's compound function\n"
}

function ffse_example() {
  echo "ffse_example v$FF3_VERSION by Jonathon@$FF3_COMMIT_DATE"
  echo '[Command Format] '
  echo '  ffse [include_key] [parameter] -- standard usage of ffse'
  echo '  ffse [include_key] [parameter] | grep [pattern] -- concatenated with grep'
  echo ' '
  echo ' '
  echo '[Basic Usage]'
  echo '  Example: ffse "Call"    '
  echo '  Result:  include all the lines containing "Call", '
  echo '           but exclude all the lines containing "//" '
  echo '           the "//" comments part is excluded as default. '
  echo ' '
  echo '  Example: ffse "Call" -ne'
  echo '  Result:  include all the lines containing "Call", '
  echo '           and also include all the lines containing "//" '
  echo '  Explanation: '
  echo '           "-ne" means no-exclusive. As default, the comments/log-code'
  echo '           will be excluded automatically by internal exclusive filter.'
  echo ' '
  echo '  Example: ffse "RFC\s3550"'
  echo '  Result:  search "RFC 3550", use "\s" or "[[:space:]]" to denote space'
  echo ' '
  echo ' '  
  echo '[More Parameter]'
  echo '  -d  : active debug mode'
  echo '  -rd : remove declaration of function, only valid when "-ne" is not added'
  echo '  -l  : only list the file(s) matched'
  echo '  -if : "ignore-file", if * is used, you had better add whole -if in quotes'
  echo '        like this:'
  echo '           fc Connection "-if=jsep_transport_controller.*,simple_peer_connection.cc" '
  echo ' '
  echo ' '
  echo '[Advanced Usage]'
  echo '  Example: ffse "Call" | grep -w "public"'
  echo '  Result:  include all the lines containing "Call", '
  echo '           but exclude all the line containing "//", '
  echo '           and include all the line containing "public". '    
  echo '  Attention: '
  echo '           the "grep" connected in this example is an extension to '
  echo '           "ffse". Using pipeline of shell to adds more capability... '
  echo '  Advice:  you can make alias such as: '
  echo '               alias gvi="grep -vi "  or '
  echo '               alias gp="grep "  or'
  echo '               alias gi="grep -i " '
  echo '           anything you want to accelarate your daily use'
}


function ffse-note() {
  echo    "[This is only for dev, not for user]"
  echo    "This is a recode for symbol which can be easily found by ffse or something TODO: "
  echo -e "   1. fc OnReceivedPacket\n"
  echo -e "   2. In TransportFeedbackAdapter::ProcessTransportFeedback():\n"
  echo    "        msg.prior_in_flight = in_flight_.GetOutstandingData(network_route_);"
  echo -e "        msg.data_in_flight = in_flight_.GetOutstandingData(network_route_);\n"
  echo    "      What's the differnce of \"prior_in_flight\" and \"data_in_flight\" returned by GetOutstandingData()?"
  echo    "      Dig it by fc/ff/fs, you will find it's related to Call::OnSentPacket(), and what's more on packet send"
  echo -e "      by Video-Engine and Voice-Engine. That can help you on grasping the whole chain of code-routine \n"
  echo -e "   3. search \"Create\" position of \"TransportFeedback\" in code-routine\n"
  echo -e "   4. fc ProbeController\n"
  echo    "   5. fd CurrentTime with -pt"
  echo    "      \"-pt\" = plain-text, it makes that more easier to concatenate with more grep... "
  echo -e "      \"-pt\" is kind of final solution to complicated process\n"
  echo    "   6. fc CreateAudioSendStream"
  echo -e "      use this command to trace call hierarchy backforward\n"
  echo -e "   7. keyword for presure test: \"Connection\"\n"
  echo    "   8. Self-Evolution:"
  echo    "      compare \"fc WebRtcAudioSendStream\" befor and after you add \"delete;\|override\" to" 
  echo -e "      the filter of FF3_EXCLUSIVE_PATTERN_FOR_DECLARATION\n"
  echo -e "   9. demo for search \"RtpTransportControllerSend::OnNetworkAvailability\" by \"fc\"\n"
  echo    "  10. demo for fg(Self-Evolution):"
  echo    "      when call \"fc SetLocalDescription\", \"peer_connection_wrapper.cc\" is listed"
  echo    "      then call \"fg peer_connection_wrapper.cc\" and some other operations...."
  echo    "      you will find that is belong to test-code."
  echo -e "      then add \"peer_connection_wrapper.*\" to ignore-list\n"
  echo    "  11. Example of over-exclude: \"fc min_probe_delta\""
  echo    "      \"min_probe_delta\" is member of \"struct BitrateProberConfig\", if you wanna find where it's argued by"
  echo    "      by \"fc min_probe_delta\", it will be excluded because one more target is located in the double-quote"
  echo -e "      as string. But the over-exclude is easy to be discovered and soloved by other way...\n"
}


function ftodo() {
  echo    "[This is only for dev, not for user]"
  echo    "[FFSE TODO List]"
  echo    "1. add -lonly: To support output to terminal without any ANSI-Escape-code, but only file list"
  echo    "               This can be help for search the second keyword, which is not in the same line"
  echo    "               with the first keyword. The reason for this todo is: now \"-l\" output the list"
  echo    "               with ANSI-Escape-code, which is too complex for send \"xargs grep\""
  echo -e "               The new param may be named as \"-wl\"(white list), or some name better....\n"
  echo    "   User Case:  If we wanna know where the \"TransportFeedback::Create\" is called. We need to"
  echo    "               call \"ffse Create\", but the symbol of Create is too common, so that there are"
  echo    "               too many of the matchs. So, to search \"Create\" directly is not a good option."
  echo    "               A good solution is use ffse to list all the file contain TransportFeedback"
  echo -e "               So, the range is narrowed, then search the \"Create\" by \"| xargs grep ....\"\n"
  echo    "   Extreme Solution:"
  echo    "               Add one more support to ffse, so that we can easily pass a file-list to ffse. "
  echo    "               As the file-list generated by temp ffse-call described in the \"User Case\", then"
  echo -e "               we can bridge two calls of ffse simply by pipe \"|\" \n"
}

alias fs=fast_find_in_c_and_cpp_source
alias fh=fast_find_in_header
alias fg=fast_find_in_gn