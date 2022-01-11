#! /bin/bash

#This project is created by Abhishek Kumar Morla aka abhishekmorla


figlet -f slant "TO DO LIST"
IN_TASK=/home/list.txt 
echo "Enter the Expo push token from the app: "
read -r token

while [ 1 ]
do
    BOLD_AND_UNDERLINED="\e[1;4m"
    GREEN="\e[32m"
    STANDARD="\e[0m"
    TODO_LIST_LABEL="\n — — — — — — — — — — — -TODO — — — — — — — — — — — — -\n"
    TODO_LIST_END=" — — — — — — — — — — — — — — — — — — — — — — — — — — \n\n"
    printf "${TODO_LIST_LABEL}"
    echo "1: New Task : "
    echo "2: Delete Task : "
    echo "3: Display Tasks: "
    echo "4: Exit" 
    printf "${TODO_LIST_END}"
    echo "Enter your choice [1-4] :"
    read -r answer
    case "$answer" in 
         1)
            read -p "What do you wish todo : " todotext
            echo "${todotext}"  >> ${IN_TASK}
            curl --silent --output /dev/null 'https://api.expo.dev/v2/push/send' \
  -H 'authority: api.expo.dev' \
  -H 'pragma: no-cache' \
  -H 'cache-control: no-cache' \
  -H 'sec-ch-ua: " Not;A Brand";v="99", "Google Chrome";v="97", "Chromium";v="97"' \
  -H 'accept: application/json' \
  -H 'content-type: application/json' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'origin: https://expo.dev' \
  -H 'sec-fetch-site: same-site' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://expo.dev/' \
  -H 'accept-language: en-US,en;q=0.9,hi;q=0.8' \
  --data-raw '[{"to":"'"${token}"'","title":"TODO LIST","body":"New Entry Added : '"${todotext}"'"}]' \
  --compressed 
        ;;

        2)
            read -p "What do you wish to delete : " deltext
            sed "/$deltext/d" ${IN_TASK} > file.new && mv file.new ${IN_TASK}
        ;;

        3)
            echo "-----------------"
            cat ${IN_TASK}
            echo "-----------------"
        ;;

        4)
            exit

    esac
done
