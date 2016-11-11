# packer(AMI)とaws-cliとchefを組み合わせたサンプル

### シナリオ

1. packer(+chef-solo)でAMIを作成
2. aws-cliでAMIからインスタンス起動
3. 起動時にuserdataでchef-clientが起動してChefServerに登録
4. ChefServerの情報を使って、起動したインスタンスを操作

### 前提条件
* 動作確認した環境はWindows10
  - gitbashをインストール済み
  - aws-cliインストール済み
  - packerのバージョンはv0.11.0(今回はCWD/packer/binに配置したバイナリを利用した)
* Chef関連
  - ChefServerはmanage.chef.ioを利用
  - cookbookは予めChefServerにもアップロードしておく(chef-soloでもchef-clientでも同じものを使用)
  - role[web,db] (cookbookの紐付け)
  - environment[production, acceptance]を作成 (cookbookのversionバインドとDB名とかのattribute)
  - chef-clientのバージョンはv12.15.19
  - starterkitをCWDに展開済み
* AWS関連
  - regionはap-northeast-1
  - ベースのAMIはami-48517b26(CentOS 7.2)
  - AWSのcredentialsは~/.aws/credentialsに配置済み
  - aws-cli/1.10.10 Python/2.7.9 Windows/8 botocore/1.4.1
  - Chefのvalidator_keyは予めS3上に配置
  - S3アクセス用のIAM-roleを作成しておく(aws-cli/aws-cli.shで指定)
  - キーペアはCWD/.ssh配下に保存済み


### 手順

* リポジトリをクローン

```
#TODO URLを追記
$ git clone https://
```

* packerの動作確認

```
$ cd packer
$ bin\packer.exe -v
```

* AMI作成

```
$ bin\packer.exe build apache-packer.json
$ bin\packer.exe build wordpress-packer.json
$ bin\packer.exe build mariadb-packer.json
```

* 出来上がったAMI_IDをメモ
* aws-cli.shでインスタンス起動
  - aws-cli <AMI_ID> <environment> <cookbook>

```
$ cd ../aws-cli
$ sh aws-cli.sh <AMI_ID> default apache
$ sh aws-cli.sh <AMI_ID> acceptance wordpress
$ sh aws-cli.sh <AMI_ID> acceptance mariadb
$ sh aws-cli.sh <AMI_ID> production wordpress
$ sh aws-cli.sh <AMI_ID> production mariadb
```

* ChefServerのWEBからNode登録を確認
* CLIでも確認

```
$ cd ../chef-repo
$ knife node list
```

* Nodeを収束

```
# 全Node
$ knife ssh 'name:*' "sudo chef-client" -x ec2-user -i ../.ssh/h-arai.pem
# apacheのみ
$ knife ssh 'recipes:apache\:\:default' "sudo chef-client" -x ec2-user -i ../.ssh/h-arai.pem
# acceptanceのみ
$ knife ssh 'chef_environment:acceptance' "sudo chef-client" -x ec2-user -i ../.ssh/h-arai.pem
# role[web]のみ
$ knife ssh 'role:web' "sudo chef-client" -x ec2-user -i ../.ssh/h-arai.pem
# productionのrole[web]のみ
$ knife ssh 'chef_environment:production AND role:web' "sudo chef-client" -x ec2-user -i ../.ssh/h-arai.pem
```

* acceptanceのWEBのPUBLIC_IPを取得

```
$ knife search node 'chef_environment:acceptance AND role:web' -a cloud.public_ipv4
```

* 取得したIPアドレスにブラウザから接続


### 参考にしたサイト

[unattended-installs]
https://docs.chef.io/install_bootstrap.html#unattended-installs

[kitchen-ec2]
https://github.com/test-kitchen/kitchen-ec2

[packer-docs]
https://www.packer.io/docs/

[packer-sample]
https://github.com/OpsRockin/centos6_ami_from_official

[packer-chef-zero]
https://github.com/threatstack/packer-templates/blob/master/chef-zero.json

[install awscli]
http://docs.aws.amazon.com/ja_jp/streams/latest/dev/kinesis-tutorial-cli-installation.html

[Amazon EC2のインスタンス起動時に自動でChef Serverと連携する方法]
http://www.ryuzee.com/contents/blog/6815
