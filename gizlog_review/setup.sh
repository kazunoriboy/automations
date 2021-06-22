#!/bin/sh

if [ $1 ==  '' ]; then
    echo '引数が必要です'
    exit 1
elif [[ !($1 =~ ^[0-9]+$) ]]; then
    echo '引数はチケット番号を整数で入力してください'
    exit 1
fi

# !!!アプリケーションまでのパスとディレクトリ構成は任意で変更してください!!!
path_to_prj=$HOME/Giztech/Backlog_Gizlog/
app_dir=www/dev_gizlog

branch="feature/GL-${1}"
count=$(git -C $path_to_prj$app_dir branch | grep "\s*$branch"$ | wc -l)

if [ $count == 0 ]; then
    echo '---------------------------------------'
    echo 'ブランチがないので、リモートから引っ張ってきます'
    echo '---------------------------------------'
    echo ''
    git -C $path_to_prj$app_dir checkout -b $branch "origin/${branch}"
else
    echo '---------------------------------------'
    echo 'ブランチがあるので、チェックアウトして最新にします'
    echo '---------------------------------------'
    echo ''
    git -C $path_to_prj$app_dir checkout $branch && git -C $path_to_prj$app_dir pull origin $branch
fi

echo ''
echo '---------------------------------------'
echo 'ソースコードの準備が終わったので、コンテナを起動します'
echo '---------------------------------------'
echo 'ウィーーーーーーン........'
echo ''

cd $path_to_prj
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

cd $path_to_prj$app_dir
    composer dump-autoload
docker-compose exec web php artisan migrate:fresh --seed

echo ''
echo '---------------------------------------'
echo 'マイグレーションファイルとかが間違っていなければ準備完了です！'
echo 'さぁ、動作確認をしよう'
echo '---------------------------------------'
echo ''

open http://localhost:8080

