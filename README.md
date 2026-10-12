# Fish Note 魚記帳

把記帳變成養魚：每記一筆帳就得到飼料，餵魚後魚會排出金幣，用金幣買魚和裝飾，布置自己的水族箱。iOS / Android 雙平台，Flutter + Flame。

| 目錄 | 內容 |
| --- | --- |
| [`docs/`](docs/README.md) | 產品規劃、功能規格、決策紀錄、開發輪巡紀錄 |
| `app/` | Flutter App |
| `prototypes/` | 網頁原型（風格基準：小丑魚「橘橘」） |

## 開發

```bash
cd app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter run
```
