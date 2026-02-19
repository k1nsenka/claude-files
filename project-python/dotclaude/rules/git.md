# Gitルール

## コミット前の確認
- gitコミットを行う前に**必ずユーザに確認を取る**
- 変更内容の概要を説明し、コミットしてよいか確認を求める
- **ユーザの承認なしにコミットを実行しない**

## コミットメッセージ規約

### prefix
以下のいずれかを使用:
- `feat`: 新機能
- `fix`: バグ修正
- `refactor`: リファクタリング
- `docs`: ドキュメント
- `test`: テスト
- `chore`: その他雑務

### 記述方法
- 何をどのように変更したかを明確に記述
- 英語prefixの後は日本語での詳細説明も可

### 禁止例
以下のような抽象的表現は禁止:
- 「リファクタリング前」
- 「作業完了」
- 「更新」

### 良い例
```
feat: ユーザー認証機能を追加
fix: ログイン時のトークン検証エラーを修正
refactor: データベース接続処理を共通化
```

## GitHub CLI (gh) の使用

### 認証確認
```bash
gh auth status
```

### リポジトリ確認
```bash
gh repo view
```

### Issue確認
```bash
gh issue list
gh issue view <number>
```

### PRの確認
```bash
gh pr list
gh pr view <number>
```

## ブランチ運用
- 機能開発は feature/ ブランチで行う
- バグ修正は fix/ ブランチで行う
- mainへの直接pushは禁止
