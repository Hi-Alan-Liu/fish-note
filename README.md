# Fish Note 魚記帳

把記帳變成養魚：每記一筆帳就得到飼料，餵魚後魚會排出金幣，用金幣買魚和裝飾，布置自己的水族箱。iOS / Android 雙平台，Expo（React Native）+ React Native Skia，以 EAS Build 線上打包。

| 目錄 | 內容 |
| --- | --- |
| [`docs/`](docs/README.md) | 產品規劃、功能規格、決策紀錄、開發輪巡紀錄 |
| `app/` | Expo App |
| `prototypes/` | 網頁原型（風格基準：小丑魚「橘橘」） |

## 開發

```bash
cd app
npm install
npx expo start          # 用手機上的 Expo Go 掃 QR code，或按 a 開 Android 模擬器
npm test                # Jest 測試
npm run typecheck       # TypeScript 型別檢查
npx expo lint           # ESLint
```

## 線上打包（EAS Build）

第一次需要登入 Expo 帳號並連結專案：

```bash
cd app
npx eas-cli@latest login
npx eas-cli@latest init
```

之後：

```bash
npx eas-cli@latest build --profile preview --platform android    # 內測用 APK
npx eas-cli@latest build --profile production --platform all     # 上架用（AAB / IPA）
```

iOS 打包需要 Apple Developer 帳號，EAS 會引導設定憑證。
