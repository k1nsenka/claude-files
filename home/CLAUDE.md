# Personal CLAUDE.md
# 配置場所: ~/.claude/CLAUDE.md（全プロジェクト共通）

## 言語設定

- 日本語でコミュニケーションする
- コード内コメントは日本語で記述

## 基本スタイル

- 実装コードは省略せず、完全な形で提供する
- 複数のアプローチがある場合は、推奨案を明示する
- 作業の進捗や問題が発生した場合は適宜報告する

## 作業の進め方

- エラーや問題が発生したら、自律的に問題分析と解決案を提示する
- ソースコード外に原因がありそうな場合は、その旨を報告する
- 同じ修正で2回以上連続で失敗したら、繰り返さずに状況を整理して報告し、別の解決策を提案する
- 既存のコードスタイルやパターンに従う。大幅な変更が必要な場合は理由を説明する

## ツール

- Python 環境管理: **uv**（pip / venv / poetry は使わない。詳細は rules/python.md）
- GitHub 操作: **gh** (GitHub CLI)

## ルールとスキル

- 常時適用ルール: `~/.claude/rules/git.md`, `~/.claude/rules/referent-before-label.md`
  （設計・調査・命名では語より先に指示対象を対応表で固定する）
- 条件付きルール（対象ファイル操作時のみ読み込み）: python / testing / security / documentation / obsidian
- Obsidian vault 内では研究メモ管理と実装の両方を行う。メモ（日報・サーベイ・議事録等）は
  `rules/obsidian.md` の記法・命名規則に従い、コードや設計書には適用しない
- スキルはコーディング用（dev-workflow, refactoring, create-pr, apple-design）と
  研究・メモ用（paper-review, meeting-minutes, progress-report, task-summary ほか）、
  文書規律用（semantic-generation）が
  `~/.claude/skills/` に統合されている。内容に応じて適切なスキルを自動選択すること
