# MyFlightLog

<img width="700" alt="スクリーンショット 2021-07-25 10 09 28" src="https://user-images.githubusercontent.com/81577119/126884617-054cfa1e-2094-4601-8b35-c5f36eeeb469.png">

「**フライトログ**」とは、パイロットが飛行時間や離着陸の回数を記録する航空日誌のことです。  
それを飛行機ファンの方々が真似して搭乗履歴を記録し始めたことから始まり、  
現在では、一般のお客様も「**ログブック**」という日記帳のようなものを使っています。

「搭乗履歴を残したいけど、ログブックを持ち歩くのは面倒・・・」  
「あまり飛行機は乗らないけど、旅行の思い出は残したい！」

そんな方向けに簡単にフライトログを記録できるサイトを作りました。

### サイトURL
https://myflightlog.work/

## ✈️ サイト概要

旅行や仕事の出張、マイルを貯めるために利用した飛行機の搭乗履歴（フライトログ）を記録し、思い出を振り返ることができるサービスです。  
飛行機の搭乗記録と一緒にコメントや画像も残すことができます。  
また、過去の記録をグラフで分析したり、地図で閲覧することができます。

<img width="700" alt="スクリーンショット 2021-07-25 10 43 36" src="https://user-images.githubusercontent.com/81577119/126885002-9bfda36f-c4fa-4651-b1f3-9985adfc3783.png">

### サイトテーマ

フライト情報を記録できるサイト

### テーマを選んだ理由

- 旅行でワクワクした気分、出張で少し気が張っている、など様々な背景があって飛行機を利用するお客様と出会った経験から、フライトの情報や写真を記録することで、思い出として振り返ることができるようなサービスを作りたいという想いがありました。
- 現在、紙媒体のログブックを利用されるお客様が多い中、コロナの影響で乗務員に記入をお願いするために私物を手渡しすることに抵抗のある方もいらっしゃいます。そのため、お客様個人の端末上で記録できるサービスを普及させたいと思い、制作に至りました。

### ターゲットユーザ

- 旅の記録を残したい一般ユーザ
- マイル修行をしているユーザ

### 主な利用シーン

- 飛行機の搭乗記録を残したい時
- 旅の思い出に浸りたい時
- 過去の搭乗記録を振り返りたい時

## ⚒ 設計書

### 画面設計

- [UI Flows(ユーザ側)](https://drive.google.com/file/d/1eCig6AOtvSYlcgh-31jngKZjCgE3eSAW/view?usp=sharing)
- [UI Flows(管理者側)](https://drive.google.com/file/d/1MMMpM0pWKP6RQavZ_hsEco_9if6FXuxn/view?usp=sharing)
- [ワイヤーフレーム](https://www.figma.com/file/cdcvc3L9PqyGPkT7vdX7ax/MyFlightLog?node-id=1%3A8)

### データベース設計

- [ER図](https://drive.google.com/file/d/1CdhKvdHR98-w6CKC0ehNwxcksxRFvjIk/view?usp=sharing)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1opfEgEOnr8rIcXPAAm4FsSskiRRTZ3AY9E34c-xKidE/edit?usp=sharing)
- [アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/16PpYxZFWqPXknxrwOysbCD2f-RRpT3ayctg4F0KVA88/edit?usp=sharing)

## 🔥 チャレンジ要素一覧

<https://docs.google.com/spreadsheets/d/1xJhEGWXtCkF1kKNeDa1nOZwmX9_8RxEwBTgiWmH_Thc/edit?usp=sharing>

## 📖 アプリ機能

- ユーザ認証機能(devise)
- 退会機能
- 検索機能
- SNS認証機能(omniauth, omniauth-google-oauth2)
- お気に入り登録
- お問い合わせ機能(Action Mailer)
- 画像アップロード機能(refile)
- グラフ描画(chartkick)
- 地図表示(Google Map API)

## ⚙️ 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：Cloud9

## 📷 使用素材
[写真AC](https://www.photo-ac.com/)  
[イラストAC](https://www.ac-illust.com/)  
[LOGO MAKER](https://logo-maker.stores.jp/)
