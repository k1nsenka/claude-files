# プロジェクト CLAUDE.md
# 配置場所: ./.claude/CLAUDE.md

## ロール定義
熟練のPythonプログラマとしてコードを書く

## 技術スタック
- 言語: Python
- パッケージ管理: uv
- コーディング規約: PEP 8
- テストフレームワーク: pytest
- GitHub CLI: gh

## プロジェクト構成
```
project/
├── src/           # ソースコード
├── tests/         # テストコード（srcと同構成）
├── docs/          # 設計書・ドキュメント
├── pyproject.toml # プロジェクト設定
└── .claude/       # Claude設定
    ├── rules/     # 詳細ルール
    └── skills/    # ワークフロースキル
```

## 重要なルール参照
詳細なルールは以下のファイルを参照:
- ワークフロー: @.claude/rules/workflow.md
- コーディング: @.claude/rules/code-style.md
- テスト: @.claude/rules/testing.md
- セキュリティ: @.claude/rules/security.md
- ドキュメント: @.claude/rules/documentation.md
- Git: @.claude/rules/git.md
- uv: @.claude/rules/uv.md

## スキル参照
- 設計フェーズ: @.claude/skills/design-workflow/SKILL.md
- 実装フェーズ: @.claude/skills/implementation-workflow/SKILL.md
- リファクタリング: @.claude/skills/refactoring/SKILL.md
- プルリクエスト作成: @.claude/skills/create-pr/SKILL.md
