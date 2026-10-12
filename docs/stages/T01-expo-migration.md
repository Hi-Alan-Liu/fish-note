# T01 技術轉換：改用 Expo

## PM — 目標

依 D-20，App 改用 Expo（React Native）並以 EAS Build 線上打包。S01、S02 已通過驗收的功能與規則**全部保留**，只換實作技術；畫面設計沿用 S01、S02 的 UI/UX 結論，不重新設計。

**本階段目標**

1. 以 Expo + TypeScript + Expo Router 重建 `app/`，只允許直式。
2. 重建 S01：主題 Token、內嵌字體、底部導覽（中間凸起「＋」）、四個分頁、全部資料表與初始資料、橘橘繪製（Skia）。
3. 重建 S02：記帳表單（自訂數字鍵盤）、編輯 / 刪除、明細列表、飼料發放規則、首頁飼料數。
4. 測試等量移植：S01、S02 的 18 項測試逐項改寫為 Jest 測試。
5. 設定 EAS Build（`eas.json`：開發版、內測 APK、正式版）。

**驗收條件**

- [ ] `tsc` 型別檢查與 ESLint 無錯誤
- [ ] Jest 測試涵蓋原本的全部情境並通過
- [ ] Android 模擬器（Expo Go）實際執行：首頁、記帳、明細、背包畫面正確
- [ ] `eas.json` 就緒，使用者登入 Expo 帳號後即可線上打包

## UI/UX — 畫面構思

沿用 [S01](S01-skeleton.md)、[S02](S02-ledger-entry.md) 的設計，無新增畫面。移植注意事項：

- 字體 Huninn、Baloo 2 改用 expo-font 載入；載入完成前顯示啟動畫面，避免字體閃動。
- 底部導覽改用 Expo Router 的 Tabs 搭配自訂 tabBar，維持中間凸起的橘色「＋」。
- 記帳表單改為 Expo Router 的 modal 頁面（從下方滑出），行為與 S02 相同。
- 提示條（「獲得 橘色飼料 A ×1」）改用自製 Toast，位置在導覽列上方。

## DEV — 實作與測試

**環境**：Expo SDK 57、React Native 0.86、React 19.2、TypeScript 6、React Compiler 開啟。

**技術選擇**

| 項目 | 選擇 | 說明 |
| --- | --- | --- |
| 資料庫 | expo-sqlite（同步 API）+ 自寫薄資料層 | 不用 Drizzle：它需要額外的 Babel / Metro 設定。改用一個 `Db` 介面，App 用 expo-sqlite，測試用 sql.js，跑同一份 SQL 與規則 |
| 資料更新 | `DataProvider` + `useQuery` | 每次寫入後版本號 +1，畫面上的查詢自動重算 |
| 路由 | Expo Router：`(tabs)` 分頁 + `transaction` formSheet | 自訂底部導覽（`expo-router/ui` 的 TabTrigger），中間「＋」不是分頁，按下開記帳表單 |
| 橘橘 | React Native Skia | 直接沿用原型的 SVG 路徑字串，姿勢參數與 Flutter 版相同 |
| 字體 | expo-font | Baloo 2 可變字型在 Android 無法載入，已轉成靜態 SemiBold 版 |

**實作內容**

| 檔案 | 內容 |
| --- | --- |
| `src/data/` | `db.ts` 介面、`expo-db.ts`、`schema.ts`（migration + 初始資料）、`queries.ts`、`ledger.ts`（發放規則）、`data-context.tsx` |
| `src/domain/` | 飼料顏色 / 等級、8 個預設分類 |
| `src/ui/` | 橘橘（Skia）、飼料圓點、金幣、空狀態、Toast、格式化 |
| `src/features/` | 首頁、明細、背包、商城、記帳表單 + 數字鍵盤、底部導覽 |
| `src/app/` | 路由：根 Stack、四個分頁、記帳 formSheet |
| `test-utils/` | sql.js 測試資料庫、包好 Provider 的 render、Jest 設定 |
| `app.json`、`eas.json` | App 名稱、套件 ID `tw.fishnote.app`、只允許直式；EAS 內測 APK / 正式版設定 |

**測試結果**

- `tsc --noEmit`：無錯誤
- `expo lint`：無錯誤
- Jest：20 / 20 通過（S01、S02 原有的 18 個情境全部移植，另外新增「切換收入自動選收入分類」「首頁讀取資料」）
- **Android 模擬器（Expo Go）實機驗證**：首頁、明細、背包畫面正確；記一筆 180 元 → 提示「獲得 橘色飼料 A ×1」→ 飼料數 1 → 明細出現 → 點擊進入編輯模式

**實機測試抓到並修正的問題**

| 問題 | 原因 | 修正 |
| --- | --- | --- |
| 打開記帳表單就崩潰（Cannot read property of null） | React Compiler 會在繪製時就讀取事件函式裡用到的 `existing!.id`；新增時 `existing` 是 null。Jest 沒有跑編譯器所以沒抓到 | 在元件頂層先算出 `existingId` 與初始值，事件函式只讀這些值 |
| 數字沒有套用 Baloo 2 | Android 不支援可變字型檔 | 轉為靜態 SemiBold 字型檔 |
| 金幣圖示是比特幣符號 | 圖示庫沒有合適的金幣 | 自繪金幣元件 |

**開發環境備註**：原本的 Pixel 9a 模擬器空間不足，另外建立專用模擬器「FishNote」（12 GB），原本的模擬器沒有被改動。

## PM — 驗收結果

| 驗收條件 | 結果 |
| --- | --- |
| tsc 與 ESLint 無錯誤 | ✅ |
| Jest 涵蓋原有情境並通過 | ✅ 20 / 20 |
| Android 模擬器實際執行正確 | ✅ 首頁、記帳、明細、編輯、背包 |
| `eas.json` 就緒 | ✅ 待使用者登入 Expo 帳號（`npx eas-cli@latest login`、`init`） |

**結論**：通過。S01、S02 的功能在 Expo 版完整重現。

**給下一階段的建議**

1. **React Compiler 的陷阱要列入檢查清單**：事件函式裡不要讀「可能是 null 的物件屬性」，一律先在元件頂層取值。每個階段都要在模擬器實際操作一次，不能只靠 Jest。
2. S03 依原計畫：首頁「本月支出」接上月結算區間、明細頁左右切換月份、Skia 圓餅圖。
3. 「上次使用的支出分類」目前只存在記憶體，S03 改為從最後一筆支出讀取。
