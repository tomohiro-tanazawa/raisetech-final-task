# 概要
* CircleCIで以下のWorkflowを実行する

# Workflow
1. リポジトリにコードをpush
2. Cloudformationによるスタック作成
3. 作成された環境に対し、Ansibleによる構成管理
4. Serverspecの実行

```
Ansible version 2.13.2
```

# 構成図
<img width=50%  src="https://user-images.githubusercontent.com/75251188/190943157-e7bb4213-7224-4616-8aa1-ff5ba324e1c2.png">

# パラメータについての補足
### CircleCIのEnvironment Valuesに以下の4つの環境変数を埋め込んでいる
* AWS_ACCESS_KEY_ID
* AWS_DEFAULT_REGION
* AWS_SECRET_ACCESS_KEY
* MASTER_KEY
  * Railsアプリケーション用

### その他パラメータ
* cloudformation/EC2_S3_template.yml
  * KeyName
  * EIP

* serverspec/ssh_config_for_circleci
 * Serverspecを実行するDockerコンテナ内の、~/.ssh/configを上書きする。テスト対象のIPをここに書く。
 
```
Host instanceA
  HostName xxx.xxx.xxx.xxx
  Port 22
  User ec2-user
  IdentityFile ~/.ssh/id_rsa
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
Host instanceC
  HostName yyy.yyy.yyy.yyy
  Port 22
  User ec2-user
  IdentityFile ~/.ssh/id_rsa
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
```

# 苦労した点
* RDSエンドポイント名をRailsアプリケーションのconfig.ymlにどう埋め込むか
* 無料枠が使えないので、コストがかさんだ。
  * 無料枠が使えない場合は、t2.microよりt3.microの方が安い

# 反省点
* はじめのうちは何度もGithubにPushしてCircleCIの挙動を見るという、非効率なやり方で進めてしまったこと。
  * 例えばAnsibleのplaybookの文法ミス。ansible-lintなど、ローカルのチェック機能を活用すれば、”CircleCIが構文エラーで止まる”という事態は防げる。
* エラー解消のための機能、デバッグ機能をもっと積極的に活用するべきだった(CircleCIであればDockerコンテナにSSH接続する機能)。 
* CircleCIにアタッチしたIAMロールの権限設定が甘い(AdministratorAccess権限を付与している）
* Serverspecを複数台ホストに一括で実行する機能の実装ができなかった(やや強引なやり方でテストを実行している)

