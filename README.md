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

