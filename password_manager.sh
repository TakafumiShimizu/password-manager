#!/bin/bash

PASSWORD_FILE="passwords.txt"

echo "パスワードマネージャーへようこそ！"
echo "サービス名を入力してください："
read service
echo "ユーザー名を入力してください："
read username
echo "パスワードを入力してください："
read -s password  # -s 

echo "$service:$username:$password" >> $PASSWORD_FILE

echo "Thank you!#!/bin/bash

PASSWORD_FILE="passwords.txt"

while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read action

    case $action in
        "Add Password")
            echo "サービス名を入力してください："
            read service
            echo "ユーザー名を入力してください："
            read username
            echo "パスワードを入力してください："
            read -s password
            echo "$service:$username:$password" >> $PASSWORD_FILE
            echo "パスワードの追加は成功しました。"
            ;;
        "Get Password")
            echo "サービス名を入力してください："
            read search_service
            grep "^$search_service:" $PASSWORD_FILE | while read -r line ; do
                IFS=':' read -ra ADDR <<< "$line"
                echo "サービス名：${ADDR[0]}"
                echo "ユーザー名：${ADDR[1]}"
                echo "パスワード：${ADDR[2]}"
            done
            if [ $? -ne 0 ]; then
                echo "そのサービスは登録されていません。"
            fi
            ;;
        "Exit")
            echo "Thank you!"
            exit 0
            ;;
        *)
            echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
            ;;
    esac
done
" 
