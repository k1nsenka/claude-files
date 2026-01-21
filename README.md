# Claude.md 分散構成ガイド（uv / gh 対応版）

## 概要

Claude公式ドキュメントのベストプラクティスに従い、CLAUDE.mdを分散構成しました。
- Python環境管理: **uv**
- GitHub操作: **gh (GitHub CLI)**

## ディレクトリ構成

```
~/.claude/                          # 個人用（全プロジェクト共通）
└── CLAUDE.md                       # 個人設定

your-project/                       # プロジェクト用
└── .claude/
    ├── CLAUDE.md                   # プロジェクト概要（300行以下推奨）
    ├── rules/                      # 詳細ルール（動的読み込み）
    │   ├── workflow.md             # 基本ワークフロー
    │   ├── uv.md                   # uv専用ルール（*.py操作時）
    │   ├── code-style.md           # コーディング規約（*.py操作時）
    │   ├── testing.md              # テスト規約（tests/**操作時）
    │   ├── security.md             # セキュリティ（機密ファイル操作時）
    │   ├── documentation.md        # ドキュメント規約（*.md操作時）
    │   └── git.md                  # Git/gh規約
    └── skills/                     # ワークフロースキル
        ├── design-workflow/
        │   └── SKILL.md            # 「設計して」で発動
        ├── implementation-workflow/
        │   └── SKILL.md            # 「実装して」で発動
        ├── refactoring/
        │   └── SKILL.md            # 「リファクタリングして」で発動
        └── create-pr/
            └── SKILL.md            # 「PRを作成して」で発動
```

## 各コンポーネントの役割

### CLAUDE.md（プロジェクト）
- **目的**: プロジェクトの全体像を示す「地図」
- **推奨行数**: 300行以下
- **内容**: 技術スタック、プロジェクト構成、ルール/スキルへの参照

### Rules（.claude/rules/）
- **目的**: ファイル種別ごとの詳細ルール
- **特徴**: `paths`フロントマターで指定したファイル操作時のみ読み込み（コンテキスト節約）
- **適用例**:
  - `uv.md` / `code-style.md`: `**/*.py`操作時のみ
  - `testing.md`: `tests/**/*.py`操作時のみ
  - `documentation.md`: `**/*.md`操作時のみ

### Skills（.claude/skills/）
- **目的**: 繰り返し可能なワークフローの定義
- **特徴**: Claudeが自動的に適切なスキルを選択
- **トリガー例**:
  - 「設計して」→ design-workflow
  - 「実装して」→ implementation-workflow
  - 「リファクタリングして」→ refactoring
  - 「PRを作成して」→ create-pr

## セットアップ方法

### 1. 個人用CLAUDE.mdの配置
```bash
mkdir -p ~/.claude
cp personal/CLAUDE.md ~/.claude/
```

### 2. プロジェクト用ファイルの配置
```bash
# プロジェクトルートで実行
cp -r project/.claude ./
```

### 3. 必要なツールのインストール

#### uv
```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

#### GitHub CLI
```bash
# macOS
brew install gh

# Ubuntu/Debian
sudo apt install gh

# Windows
winget install GitHub.cli
```

#### 認証
```bash
gh auth login
```

### 4. 確認
```bash
# Claude Codeで確認
claude
# > What Skills are available?
# > /memory
```

## uv クイックリファレンス

```bash
# プロジェクト初期化
uv init

# 依存関係同期（仮想環境自動作成）
uv sync

# パッケージ追加
uv add requests
uv add --dev pytest

# スクリプト実行
uv run python script.py
uv run pytest
```

## gh クイックリファレンス

```bash
# 認証
gh auth login

# PR作成
gh pr create --title "タイトル" --body "説明"

# PR一覧
gh pr list

# PR確認
gh pr view
```

## 個人CLAUDE.md vs プロジェクトCLAUDE.md

| 項目 | 個人 (`~/.claude/`) | プロジェクト (`./.claude/`) |
|------|---------------------|----------------------------|
| 適用範囲 | 全プロジェクト | 特定プロジェクトのみ |
| 内容例 | 言語設定、個人的スタイル | 技術スタック、チーム規約 |
| 共有 | 共有しない | Gitでチーム共有 |
| 優先度 | 低 | 高（プロジェクトが上書き） |

## 参考リンク

- [Claude Code公式: Agent Skills](https://code.claude.com/docs/ja/skills)
- [Claude Code公式: Memory](https://code.claude.com/docs/en/memory)
- [スキル作成ベストプラクティス](https://platform.claude.com/docs/ja/agents-and-tools/agent-skills/best-practices)
- [uv公式ドキュメント](https://docs.astral.sh/uv/)
- [GitHub CLI公式](https://cli.github.com/)
