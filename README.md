# toybox

## debug install

### android

Androidのワイヤレスデバッグを有効化してIPアドレス、ポート、ペアコードを取得しておく

```
adb pair IPADDR:PORT PAIR_CODE
flutter devices
flutter build apk
flutter install -d DEVICE_ID
```

## リリース手順

 - pubspec.yamlのバージョンを上げる
 -