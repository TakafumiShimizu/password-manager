#!/bin/bash

PASSWORD_FILE="passwords.txt"
ENCRYPTED_FILE="passwords.txt.gpg"

function addPassword {
    echo "サービス名を入力してください："
    read service
    echo "ユーザー名を入力してください："
    read username
    echo "パスワードを入力してください："
    read -s password
    echo "$service:$username:$password" >> $PASSWORD_FILE
    # ファイルを暗号化し、元のファイルを削除
    gpg -c $PASSWORD_FILE
    rm $PASSWORD_FILE
    echo "パスワードの追加は成功しました。"
}

function getPassword {
    # 暗号化されたファイルを一時的に復号化
    gpg -d $ENCRYPTED_FILE > $PASSWORD_FILE
    echo "サービス名を入力してください："
    read search_service
    found=$(grep "^$search_service:" $PASSWORD_FILE)
    if [ -z "$found" ]; then
        echo "そのサービスは登録されていません。"
    else
        echo $found
    fi
    # 復号化した一時ファイルを削除
    rm $PASSWORD_FILE
}

while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read action

    case $action in
        "Add Password") addPassword ;;
        "Get Password") getPassword ;;
        "Exit") echo "Thank you!"; exit 0 ;;
        *) echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。" ;;
    esac
done
