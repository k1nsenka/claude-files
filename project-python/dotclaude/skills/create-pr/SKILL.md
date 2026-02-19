---
name: create-pull-request
description: |
  GitHub CLIを使用してプルリクエストを作成するワークフロー。
  「PRを作成して」「プルリクエストを作成して」「マージリクエストを作成して」
  「レビュー依頼して」と言われた時に使用。
---

# プルリクエスト作成ワークフロー

## 概要
GitHub CLI (gh) を使用してプルリクエストを作成します。

## 前提条件
- GitHub CLIがインストールされていること
- `gh auth login` で認証済みであること

## 事前確認

### Step 1: 認証状態の確認
```bash
gh auth status
```

### Step 2: リポジトリ確認
```bash
gh repo view
```

### Step 3: 現在のブランチ確認
```bash
git branch --show-current
```

## PR作成ワークフロー

### Step 1: 変更内容の確認
```bash
# 変更ファイル一覧
git status

# 差分確認
git diff --stat main
```

### Step 2: テスト実行
```bash
uv run pytest
```
**全テストがパスすることを確認**

### Step 3: コミット（未コミットの場合）
```bash
# ユーザーに確認後
git add .
git commit -m "feat: 機能の説明"
```

### Step 4: プッシュ
```bash
git push -u origin $(git branch --show-current)
```

### Step 5: PR作成
```bash
# 対話的に作成
gh pr create

# またはオプション指定で作成
gh pr create \
  --title "PR タイトル" \
  --body "PR の説明" \
  --base main
```

### Step 6: PR確認
```bash
# 作成したPRを確認
gh pr view

# ブラウザで開く
gh pr view --web
```

## PRテンプレート

### タイトル形式
```
[prefix] 変更内容の要約
```
例: `[feat] ユーザー認証機能の追加`

### 本文テンプレート
```markdown
## 概要
この PR で行った変更の概要

## 変更内容
- 変更点1
- 変更点2

## テスト
- [ ] ユニットテスト追加/更新
- [ ] `uv run pytest` 全パス

## 関連Issue
closes #123
```

## よく使うghコマンド

### PR一覧
```bash
gh pr list
```

### PR詳細確認
```bash
gh pr view <number>
```

### PRのチェックアウト
```bash
gh pr checkout <number>
```

### PRのマージ
```bash
gh pr merge <number>
```

### ドラフトPR作成
```bash
gh pr create --draft
```

### レビュアー指定
```bash
gh pr create --reviewer username1,username2
```

### ラベル付与
```bash
gh pr create --label "enhancement"
```

## 重要なルール
- **PRを作成する前に必ずユーザーに確認を取る**
- タイトルと説明は具体的に記述
- テストが全てパスしていることを確認
- mainブランチへの直接プッシュは禁止
