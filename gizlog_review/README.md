# gizlog挙動テスト用スクリプト

## 概要

gizlogの挙動確認をお助けするためのスクリプトです。  

やっていることは、

1. ローカルのブランチを最新にする
2. コンテナの起動
3. マイグレーション＆シーディング
4. ブラウザを開く

だけです。
※ エラーハンドリングをそこまでしっかりやっていないので、使い方ミスると変なことになります。

## 使い方

### 1.env.exampleをコピーし、.envを作成

```
cp .env.example .env
```

### 2.環境変数を設定

環境変数はローカルのパス（コンテナ内のパスではないので注意）
```shell
# アプリケーションのルートまでの絶対パスを記載
PRJ_PATH="$HOME/Giztech/gizlog/"

# docker-compose.ymlがあるディレクトリまでの絶対パスを記載
APP_PATH="${PRJ_PATH}src/"
```

### 3.setup.shに実行権限追加

```shell
chmod +x ./setup.sh
```

### 4.aliasに追加（任意）
何でもいいと思いますが、僕はglで実行できるようにしました。

### 5.引数にチケット番号だけ渡してコマンドを実行

例
```shell
gl 1401
```

### 6.downしたい時は引数にdownを渡すべし

例
```
gl down
```

