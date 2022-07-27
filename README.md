# README

## 使い方

### rubyとrailsのバージョン
ruby: 2.7.6
rails: 6.1.6

### ユーザーの作成

user_nameとpasswordは任意
```
User.create(user_name: "test_user", password: "password", password_confirmation: "password")
```
あとはbundle installとrails sだけすればOKかと思います。

## 補足
- 拡張の想定等は不要とのことでしたので、ServiceやModuleに切り出さずにControllerに処理をまとめています
- client_secretなども、今回に限ってはベタ書きしているため、master.key等は不要かと思います
