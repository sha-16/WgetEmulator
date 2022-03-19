#!/bin/bash

function makeRequest(){
        exec 3<>/dev/tcp/$host/$port
        echo -en "GET /$file HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
        (while read line; do
         [[ "$line" == $'\r' ]] && break
        done && cat) <&3
        exec 3>&-
}


if [ $# -eq 3 ]; 
then  
        host=$1
        port=$2
        file=$3

        makeRequest > $file
else 
        echo -e "\n[+] Use: $0 <host> <port> <file>"
        echo -e "\n~ Example:"
        echo -e "\n        $ $0 10.10.10.40 80 file.txt"
        echo -e "\n~ Happy Hacking!"
fi
