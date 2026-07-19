# claude-files — 統一 Claude Code 設定

コーディング用と日々のメモ（Obsidian）用に分かれていた 2 つの `.claude` 構成を、
**ユーザーレベル（`~/.claude`）の単一構成に完全統一**したリポジトリ。
Obsidian vault 内で実装も行う運用のため、プロジェクト側に `.claude/` を置く必要はない。

- スキルは description に基づいて自動選択されるため、コーディング用と研究・メモ用が
  同居しても干渉しない
- ルールは `paths` フロントマターにより**対象ファイルの操作時のみ読み込まれる**
  （Python ルールは `.py` 操作時、Obsidian 記法ルールは `.md` 操作時のみ。コンテキスト節約）
- `install.sh` が `~/.claude` へ **symlink** を張るため、このリポジトリを編集すれば
  即座に反映される（コピー運用によるドリフトが起きない）

## ディレクトリ構成

```
claude-files/
├── install.sh                 # ~/.claude へ展開（symlink + settings マージ）
└── home/                      # → ~/.claude（全プロジェクト共通）
    ├── CLAUDE.md              # 個人設定（言語・スタイル・作業の進め方）
    ├── settings.json          # 共通 permissions / 通知 hooks（既存設定へ非破壊マージ）
    ├── rules/                 # ルール（paths 指定は条件付き読み込み）
    │   ├── git.md             # Git 規約（常時）
    │   ├── referent-before-label.md  # 語より先に指示対象を固定（常時）
    │   ├── python.md          # uv + コーディングスタイル（*.py 操作時）
    │   ├── testing.md         # テスト規約（tests/** 操作時）
    │   ├── security.md        # 機密ファイル（.env* 等の操作時）
    │   ├── documentation.md   # 設計書規約（docs/** 操作時）
    │   └── obsidian.md        # メモの記法・命名規則（*.md 操作時。コード付属文書は対象外）
    ├── skills/
    │   ├── dev-workflow/      # 設計→承認→実装→テスト（旧 design+implementation 統合）
    │   ├── refactoring/       # リファクタリング
    │   ├── create-pr/         # PR 作成（gh）
    │   ├── apple-design/      # Apple 流の流体 UI・モーション設計（WWDC 由来、日本語訳）
    │   ├── semantic-generation/  # 対応表を先に提出し語より先に指示対象を固定する生成手順
    │   ├── paper-review/      # 論文査読（標準 / top-tier モード統合）
    │   ├── paper-review-panel/# ★ 5査読者並列 + メタレビューのオーケストレータ
    │   ├── meta-review/       # 査読統合プロトコル（meta-reviewer 用）
    │   ├── japanese-academic-style-check/  # 日本語論文文体チェック
    │   ├── technical-writing/ # 黄金フォーマット執筆
    │   ├── research-intro/    # 論文イントロ作成
    │   ├── meeting-minutes/   # vtt → 議事録
    │   ├── progress-report/   # 進捗報告作成
    │   ├── task-summary/      # TODO 集約
    │   ├── create-project/    # 研究プロジェクトの新規立ち上げ（vault テンプレート）
    │   └── vault-observe/     # vault 全体の進捗観測・週報/月報/年報生成
    └── agents/                # 査読者エージェント
        ├── reviewer-a.md      # 方法論・妥当性・再現性
        ├── reviewer-b.md      # 分析の深さ（Analysis Lover）
        ├── reviewer-c.md      # 産業応用（Industry Pragmatist）
        ├── reviewer-d.md      # 理論（Theoretical Stickler）
        ├── reviewer-e.md      # 実験（Empirical Hardliner）
        └── meta-reviewer.md   # メタレビュー統合
```

## セットアップ

```bash
./install.sh
```

- `~/.claude/{CLAUDE.md,rules,skills,agents}` を symlink 化（既存物は `~/.claude/backups/pre-unify-*/` へ退避）
- `~/.claude/settings.json` へ共通 permissions / hooks をマージ（`model` 等の既存キーは保持、`.bak` 作成）

プロジェクト側の設定は不要。プロジェクト固有のドメイン知識や特殊なコマンドを
教えたい場合のみ、そのプロジェクトに `CLAUDE.md` を作成する。

> **注意**: 過去にプロジェクトや vault へコピーした旧 `.claude/`（rules/skills 一式）は、
> ユーザーレベルと二重定義になるため削除すること。

## 主な使い方

| やりたいこと | トリガー例 |
|-------------|-----------|
| 設計から開発 | 「設計して」→ 承認 →「実装して」（dev-workflow） |
| Apple 風の流体 UI 実装 | 「ボトムシートを iOS っぽい挙動で実装して」（apple-design） |
| 設計・調査文書の用語固定 | 設計書・調査報告・命名の着手時に対応表を先に作成（semantic-generation + referent-before-label） |
| PR 作成 | 「PR を作成して」（create-pr） |
| 論文の簡易査読 | 「この論文を査読して」（paper-review） |
| トップ会議基準の査読 | 「top-tier 基準で査読して」 |
| 模擬プログラム委員会 | 「査読パネルにかけて」→ 5 査読者が並列実行 + メタレビュー |
| 議事録 | 「この vtt から議事録を作成して」（meeting-minutes） |
| 週次 TODO 整理 | 「今週の日報からタスクをまとめて」（task-summary） |
| 進捗報告 | 「来週のラボ MTG 用に 5 分の進捗報告を作成して」（progress-report） |

## 設計メモ

- **settings.json を symlink にしない理由**: Claude Code 本体が `/model` などの設定を
  このファイルへ書き込むため。install.sh は既存キーを保持したままマージする
- **obsidian.md と documentation.md の棲み分け**: どちらも Markdown を対象とするが、
  obsidian.md はメモ（日報・サーベイ・議事録等）、documentation.md は開発プロジェクトの
  `docs/` 配下の設計書に適用する。ルール冒頭に適用範囲を明記してあり、Claude が
  ファイルの置き場所と書式から判断する
- **旧構成からの変更点**: `project-obsidian/` と `project-python/` の 2 系統を廃止し、
  重複していた settings（完全同一だった）と査読スキル 2 種（conference / top-tier）を統合。
  `reviewer-e` の name が `reviewer-d` と重複していたバグを修正。
  当初あった `templates/`（プロジェクト個別配置用）も、vault 内で実装も行う運用のため
  廃止してグローバルに一本化した
