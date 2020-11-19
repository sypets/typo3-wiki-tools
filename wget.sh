#!/bin/bash

URL=https://wiki.typo3.org
level=infinite

function usage()
{
	echo "Usage: $0 [-h] [-l LEVEL]"
	echo " -h : help"
	echo " -l LEVEL: level recurse - no -l means infinite"
	exit 0
}

while getopts "l:h" opt;do
  case $opt in 
    h)
      usage
      ;;        
    l)
      level=${OPTARG}
      ;;
    \?)
      echo "invalid option"
      usage
      ;;
  esac
done
shift $((OPTIND-1))

# wget options:
# -k: convert links
# -m: mirror
# -nc: no clobber (do not overrwrite files with same name)
# -p: download necessary assets
# -E: append .html to HTML file if doesn't end in html

wget_options="-E -p -nc -m -k"
if [[ $level != infinite ]];then
	wget_options="${wget_options} -l ${level}"
fi

echo "wget ${wget_options} $URL"
wget ${wget_options} "$URL"

