#!/bin/bash

if [ $1 =  '' ]; then
    echo '引数が必要です'
    exit 1
fi

# !!!アプリケーションまでのパスとディレクトリ構成は任意で変更してください!!!
source ./.env

if [ $1 = 'down' ]; then
    cd $PRJ_PATH
        docker-compose down
    exit 0
elif [[ !($1 =~ ^[0-9]+$) ]]; then
    echo '引数はチケット番号を整数で入力してください'
    exit 1
fi

branch="feature/GL-${1}"
count=$(git -C $APP_PATH branch | grep "\s*$branch"$ | wc -l)

if [ $count = 0 ]; then
    echo '---------------------------------------'
    echo 'ブランチがないので、リモートから引っ張ってきます'
    echo '---------------------------------------'
    echo ''
    git -C $APP_PATH fetch origin $branch
    git -C $APP_PATH checkout -b $branch "origin/${branch}"
else
    echo '---------------------------------------'
    echo 'ブランチがあるので、チェックアウトして最新にします'
    echo '---------------------------------------'
    echo ''
    git -C $APP_PATH checkout $branch && git -C $APP_PATH pull origin $branch
fi

echo ''
echo '---------------------------------------'
echo 'ソースコードの準備が終わったので、コンテナを起動します'
echo '---------------------------------------'
echo 'ウィーーーーーーン........'
echo ''

cd $PRJ_PATH
    docker-compose up -d

echo '---------------------------------------'
echo 'コンテナの起動完了'
echo '---------------------------------------'
echo ''
echo '---------------------------------------'
echo 'テストデータを投入します'
echo '---------------------------------------'
echo ''
echo 'ゴゴゴゴゴゴゴゴゴゴゴゴゴゴ......'

docker-compose exec php-fpm composer install
docker-compose exec php-fpm composer dump-autoload
docker-compose exec php-fpm php artisan migrate:fresh --seed

echo ''
echo '---------------------------------------'
echo 'マイグレーションファイルとかが間違っていなければ準備完了です！'
echo 'さぁ、動作確認をしよう'
echo '---------------------------------------'
echo ''

open http://localhost:8080

exit 0
