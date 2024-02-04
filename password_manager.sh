#!/bin/bash

PASSWORD_FILE="passwords.txt.gpg"
TEMP_FILE="temp_passwords.txt"

handle_add_password() {
    echo "サービス名を入力してください："
    read service
    echo "ユーザー名を入力してください："
    read username
    echo "パスワードを入力してください："
    read -s password
    echo "$service:$username:$password" >> $TEMP_FILE

    gpg -c --batch --yes --passphrase YOUR_PASSPHRASE $TEMP_FILE
    mv $TEMP_FILE.gpg $PASSWORD_FILE

    echo "パスワードの追加は成功しました。"
}

handle_get_password() {
   
    gpg -d --batch --yes --passphrase YOUR_PASSPHRASE $PASSWORD_FILE > $TEMP_FILE

    echo "サービス名を入力してください："
    read search_service
    found=$(grep "^$search_service:" $TEMP_FILE)

    if [ -z "$found" ]; then
        echo "そのサービスは登録されていません。"
    else
        IFS=':' read -ra ADDR <<< "$found"
        echo "サービス名：${ADDR[0]}"
        echo "ユーザー名：${ADDR[1]}"
        echo "パスワード：${ADDR[2]}"
    fi

    rm $TEMP_FILE
}

while true; do
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read action

    case $action in
        "Add Password")
            handle_add_password
            ;;
        "Get Password")
            handle_get_password
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

