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

echo "Thank you!" 
