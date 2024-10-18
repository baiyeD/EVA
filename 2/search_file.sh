#!/bin/bash

show_help(){
	echo "search_file.sh is a script to search files in a particular directory."
	echo "USAGE:"
	echo "  ./search_file.sh [OPTIONS]"
	echo ""
	echo "OPTIONS:"
	echo "  --extension <ext>      Specify the file extension to search for."
	echo "  --interactive          Run the script in interactive mode."
	echo "  --directory <dir>      Specify the directory to search in."
	echo "  --help                 Show this help message."
}

search_files(){
	local ext="$1"
	local dir="$2"
	local count=0
	file=$(find "$dir" -type f -name "*.$ext")
	for file in $file; do
		if [[ "$file" == $HOME* ]]; then
            echo "~${file#$HOME}"
        else
            echo "$file"
        fi
        count=$((count+1))
    done
	echo "Total $count files"
}

interactive_mode() {
    while true; do
        echo -n "Please input file extension (q to quit): "
        read ext
        if [[ "$ext" == "q" ]]; then
            break
        fi

        echo -n "Please input directory to search (q to quit): "
        read dir
        if [[ "$dir" == "q" ]]; then
            break
        fi

        search_files "$ext" "$dir"
    done
}

# $#表示传入参数个数
if [[ "$#" -eq 0 ]]; then
    show_help
    exit 1
fi

if [[ "$1" == "--interactive" ]]; then
    interactive_mode
    exit 0
elif [[ "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "--extension" && "$3" == "--directory" ]]; then
    search_files "$2" "$4"
    exit 0
else
    show_help
    exit 1
fi
