---
name: vault-observe
description: "Obsidian vault（nemovault）全体の進捗観測スキル。全プロジェクトの00_index.mdとgit履歴・日報・Thinoメモを観測し、PROJECTS.md更新・週報/月報/年報の生成・停滞（dormant）プロジェクト検出を一括実行する。「週報を作って」「月次観測して」「年次観測して」「vaultを観測して」などのリクエストに対応。"
---

# vault 観測スキル

vault 全体の進捗を観測し、ダッシュボード更新と期間集約報告を生成する。最低週次の実行を推奨。

## 前提（vault 構造）

- ダッシュボード: `000-vault/PROJECTS.md`（本スキルが更新する唯一の一覧表）
- 各プロジェクト `1xx-*/00_index.md` の frontmatter: `project_id` / `status` / `started` / `updated` / `deadline`
- 報告の出力先: `010-progress/{daily,weekly,monthly,yearly}/`
- status の語彙: `active` / `pending` / `dormant`（2ヶ月更新なし）/ `closed` / `archived`

## 入力

1. 全プロジェクトの `00_index.md`（frontmatter と「現在地と次のマイルストーン」節）
2. `git log --since=<期間> --oneline --name-only`（プロジェクト別の実更新の検出。パスのプレフィックスで帰属を判定）
3. `010-progress/daily/` の対象期間の日報（`YYYYMMDD-日報.md`）
4. `DailyNotes/` の対象期間の Thino メモ（**読み取り専用**。変更・移動禁止）

## 処理手順

### Step 1: 観測と PROJECTS.md 更新

1. 各プロジェクトの `00_index.md` frontmatter を読む
2. `git log --since` で対象期間に実更新のあったプロジェクトを特定し、該当プロジェクトの `00_index.md` の `updated` を最終実更新日に更新（**frontmatter の status / updated 以外は書き換えない**）
3. `000-vault/PROJECTS.md` の表（status / 最終更新 / 次のマイルストーン）を同期する

### Step 2: 期間集約

- **週報** `010-progress/weekly/YYYYWXX-週報.md`（例: `2026W28-週報.md`）:
  タスク集約は **task-summary スキルに委譲**し、その出力＋プロジェクト別の今週の動き（git log とメモの要約）＋来週の予定で構成する
- **月報** `010-progress/monthly/YYYYMM-月報.md`: 当月の週報を集約し、プロジェクト別ハイライト・マイルストーン進捗・**dormant 検出結果とアーカイブ提案**を記載する
- **年報** `010-progress/yearly/YYYY-年報.md`: 月報を集約し、テーマ系譜（新設・昇格・アーカイブ）を記録する
- 報告会向けの発表資料が必要な場合は **progress-report スキルに委譲**する（本スキルで重複実装しない）

### Step 3: dormant 検出とアーカイブ提案

1. `updated` が観測日から **2ヶ月以上前**のプロジェクト（status: active/pending）を dormant 候補として列挙
2. ユーザーに提示し、承認されたら `00_index.md` の `status: dormant` に変更
3. 月報に「アーカイブ提案」として記載（`900-archive/` への移動は**提案のみ**。実行はユーザーが別途指示し、移動時は 900-archive/00_index.md の台帳に追記＋status: archived）

## 出力フォーマット（週報）

```markdown
---
title: YYYYWXX-週報
date: YYYY-MM-DD
tags:
  - type/weekly
---

# YYYY年 第XX週 週報（MM/DD〜MM/DD）

## プロジェクト概況
| project_id | status | 今週の動き | 次のマイルストーン |

## タスクサマリー
（task-summary の出力を転記または参照）

## 気づき・リスク

## 来週の予定
```

## 注意事項

1. `DailyNotes/` は読み取り専用（Thino の管理下）。`claude-files/` は観測対象外
2. 各プロジェクトへの書き込みは `00_index.md` の frontmatter（status / updated）に限定する
3. アーカイブ移動・status の closed 化など不可逆な変更は必ずユーザー承認を得る
4. 週番号は ISO 週番号（`date +%GW%V` 相当）を用いる

## 関連スキル

- task-summary（タスク抽出・集約 — 週報の素材）
- progress-report（進捗報告会資料の生成）
- meeting-minutes（議事録作成 — mtg/ の同日付検索）
