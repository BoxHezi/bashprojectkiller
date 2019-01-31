#!/usr/bin/bash

declare -r ignore_num=4

function search_pid() {
    echo 'Program to kill: '$1
    declare -a id_list=( `ps -aux | grep $1 --color=auto | awk '{print $2}'` )

    # get amount of id
    declare -r local id_count=${#id_list[@]}

    # remove pid which for this script and grep
    declare -r local id_limit=$((id_count-ignore_num))

    for (( i=0; i<$id_limit; i++))
    do
        echo "Killing ${id_list[i]}"
        sudo kill -9 ${id_list[i]}
    done
}

function check_root() {
    if [[ $EUID -ne 0 ]]; then
        printf "Please run the script as root"
        exit 1
    elif [[ "$#" -ne 1 ]]; then
        printf "Please enter 1 program to terminate"
    else
        search_pid $1
    fi
}

check_root $1