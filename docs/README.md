# Fish Note 魚記帳 — 產品規劃文件

> 版本：v0.1 · 2026-10-12
> 線上版：https://claude.ai/code/artifact/00cb9132-f692-4e1b-bc7e-2de787888b13

iOS / Android 雙平台記帳 App，以可愛水族箱養成作為記帳動機：記帳得飼料 → 餵魚 → 魚排出金幣 → 點擊回收 → 購買魚與裝飾。

## 文件目錄

| # | 文件 | 內容 |
| --- | --- | --- |
| 01 | [產品概述](01-product-overview.md) | 定位、目標用戶、核心循環 |
| 02 | [核心玩法與經濟系統](02-gameplay-economy.md) | 飼料顏色、等級、金幣產出、防刷 |
| 03 | [美術風格](03-art-style.md) | 可愛海底風格、裝飾類型、介面 |
| 04 | [技術架構](04-tech-architecture.md) | Expo（React Native）+ Skia、資料表、離線計時、EAS 打包 |
| 05 | [三階段總覽](05-roadmap.md) | 路線圖與階段門檻 |
| 06 | [第一階段：MVP](06-phase-1-mvp.md) | 跑通核心循環 |
| 07 | [第二階段：養成深度](07-phase-2-growth.md) | 內容擴充與記帳強化 |
| 08 | [第三階段：雲端與社交](08-phase-3-cloud-social.md) | 雲端同步、社交、商業模式 |
| 09 | [風險與待決事項](09-risks-open-questions.md) | 風險對策、尚待確認事項 |
| 10 | [決策紀錄](10-decision-log.md) | 已拍板的產品決策 D-01 起 |
| — | [功能規格 features/](features/README.md) | 首頁、記帳統計、商城、背包、DIY、教學、魚的心情、設定 |

## 參考素材

- **風格基準角色：小丑魚「橘橘」** — `../prototypes/clownfish/index.html`（[線上預覽](https://claude.ai/artifact/5LS3ZefRSnSQEDnYSNo7ji)）。所有新魚種、裝飾、UI 都以此造型風格為準，規範見 [03 美術風格](03-art-style.md)。
- 風格參考圖：`assets/reference-style.webp`
