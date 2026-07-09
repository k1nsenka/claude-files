---
name: create-project
description: "Obsidian vault（nemovault）に新しい研究プロジェクトをテンプレートから立ち上げるスキル。番号採番・雛形コピー・00_index/AGENTS.md記入・PROJECTS.md登録までを一括実行。「新しいプロジェクトを作って」「プロジェクトを立ち上げて」「○○の研究プロジェクトを新設して」などのリクエストに対応。"
---

# プロジェクト立ち上げスキル

vault の標準構造（`000-vault/templates/project/`）から新プロジェクトを作成する。
規約の正本はルート `AGENTS.md` §4 と `000-vault/templates/project/README.md`（本スキルはその自動化）。

## 前提

- vault ルート: `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/nemovault`（パスにスペース → Bash では**全パスをダブルクォート**）
- 番号規約: 研究プロジェクトは `1xx`（10刻み）。0xx=運用・9xx=アーカイブは対象外
- **1テーマ = 1プロジェクト**。既存プロジェクトの派生なら新プロジェクトを切る

## 入力（不足分はユーザーに確認）

1. **テーマ略称**（英小文字ケバブケース。例: `advance-settle`）— ディレクトリ名・project_id に使用
2. **テーマの1〜3行説明**（研究の問い / 目的）
3. deadline（任意。投稿締切等）/ 関連する前身テーマ（任意。900-archive 内なら THEMES.md へのポインタを張る）

## 処理手順

### Step 1: 採番

`ls -d "1"[0-9][0-9]-*` で既存の 1xx を列挙し、**最大番号 + 10** を採番する（例: 100/110/120 が既存なら 130）。
ユーザーが番号を指定した場合は既存と重複しないことを確認する。

### Step 2: 雛形コピーと初期化

```bash
cd "<vaultルート>"
cp -R "000-vault/templates/project" "1xx-{テーマ略称}"
mv "1xx-{テーマ略称}/code_template" "1xx-{テーマ略称}/code_{テーマ略称}"
```

- `mtg/`・`refs/` は最初のファイルを置くときに作ればよい（空ディレクトリを作らない）
- `README.md`（工程レター表）はテンプレートの正本なので**コピー先から削除**する（参照はテンプレート側へ）

### Step 3: 文書の記入

1. `00_index.md`: frontmatter（`title` / `project_id: 1xx-{略称}` / `status: active` / `started`・`updated` = 今日 / `deadline` / `tags: [project/{略称}]`）と「研究の問い」「現在地と次のマイルストーン」を記入。プレースホルダを残さない
2. `AGENTS.md`: テーマ・スコープ宣言・固有規約を記入（進捗は書かない — 00_index が正本）
3. `.claude/CLAUDE.md`: 先頭 `@../AGENTS.md` を維持し、Claude 固有の補足のみ記入
4. `.claude/settings.local.json`: 必要な WebFetch ドメイン等に調整

### Step 4: 登録と追跡

1. `000-vault/PROJECTS.md` の表に1行追加（project_id は `[[1xx-{略称}/00_index|1xx-{略称}]]` 形式、status / 概要 / 最終更新 / 次のマイルストーン）
2. git 追跡: `git add "1xx-{略称}/"` + **`git add -f "1xx-{略称}/.claude/settings.local.json"`**（グローバル ignore 対象のため -f 必須）

### Step 5: 検証とコミット

1. `uv run --no-project python "000-vault/tools/check_links.py"` で壊れリンクが増えていないことを確認
2. frontmatter が YAML として валid か（title はクォート、日付は YYYY-MM-DD）を確認
3. コミットは**ユーザー承認後**: `feat: 1xx-{略称}プロジェクトを新設（{テーマ1行}）`

## 注意事項

1. vault ルートの構造（0xx/9xx・不動ディレクトリ）には触れない
2. 既存プロジェクトからのファイル移動が必要な場合は本スキルの範囲外（ユーザーと個別に計画する）
3. テンプレート自体（`000-vault/templates/project/`）を書き換えない

## 関連

- ルート `AGENTS.md` §4（作成手順の正本）/ §5（肥大化防止ルール）
- `000-vault/templates/project/README.md`（命名規約・工程レター表）
- vault-observe（新プロジェクトは次回観測から PROJECTS.md 集計対象になる）
