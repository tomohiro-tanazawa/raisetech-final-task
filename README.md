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
