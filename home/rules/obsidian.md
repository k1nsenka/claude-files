---
paths:
  - "**/*.md"
---

# Obsidian メモルール（記法・命名規則）

## 適用範囲

このルールは **Obsidian vault のメモ**（日報・サーベイ・議事録・研究議論・TODO 等）に適用する。
開発プロジェクトの README、`docs/` 配下の設計書、コード付属のドキュメントには適用しない
（それらは `rules/documentation.md` に従う）。どちらか迷う場合は、ファイルの置き場所と
既存ファイルの書式から判断する。

## ファイル命名規則

| ファイル種別 | 命名パターン | 例 |
|-------------|-------------|-----|
| 日報 | `YYYYMMDD-日報.md` | `20260709-日報.md` |
| サーベイ | `YYYYMMDD-サーベイ-[テーマ].md` | `20260709-サーベイ-LLM推論.md` |
| 研究議論メモ | `YYYYMMDD-研究議論-[相手/場].md` | `20260709-研究議論-ラボMTG.md` |
| 研究議論プレゼン | `YYYYMMDD-研究議論.pptx` | `20260709-研究議論.pptx` |
| 会議議事録 | `YYYYMMDD-議事録-[会議名].md` | `20260709-議事録-週次MTG.md` |
| Zoomトランスクリプト | `GMTxxxxxxxx-xxxxxx_Recording_transcript.vtt` | — |
| TODO | `TODO-[プロジェクト名].md` | `TODO-修論.md` |
| 週報 | `YYYYWXX-週報.md` | `2026W28-週報.md` |

## 基本動作原則

1. **メモ作成時**: 必ずフロントマター（YAML）を付与し、関連メモへのリンクを積極的に作成する
2. **タスク抽出時**: `- [ ]` 形式のタスクを検出・集約し、期限（📅）と優先度（🔺高/🔸中/🔹低）を明示する
3. **レポート作成時**: 黄金フォーマット（結論→理由→詳細→結論）を適用し、出典を明確に記載する

---

## 1. フロントマター（YAML）

すべてのメモにはフロントマターを付与する。

```yaml
---
title: メモのタイトル
date: 2026-07-09
tags:
  - research/survey
  - topic/llm
status: draft | in-progress | completed
related:
  - "[[関連メモ1]]"
  - "[[関連メモ2]]"
---
```

- 必須フィールド: `title` / `date`（YYYY-MM-DD）/ `tags`（配列）
- オプション: `status`（draft / in-progress / completed）, `related`, `due`, `priority`

## 2. 内部リンク

```markdown
[[メモ名]]                    # 基本リンク
[[メモ名|表示テキスト]]        # エイリアス
[[メモ名#見出し]]             # 見出しへのリンク
[[メモ名#^block-id]]          # ブロックへのリンク
```

原則:
1. **関連概念は積極的にリンク**: 既存メモとの関連があれば必ずリンクを作成する
2. **将来のメモへもリンク可**: 未作成リンクも活用する
3. **エイリアスの活用**: 文脈に合わせて表示テキストを変更する

## 3. 数式

- 簡単な数式はインライン `$E = mc^2$`、複雑・重要な数式はブロック `$$...$$`
- 連番が必要な場合は `\tag{1}` を手動で付与する

## 4. タスク管理

```markdown
- [ ] 未完了 / - [x] 完了 / - [-] キャンセル / - [>] 延期 / - [?] 要確認
- [ ] タスク内容 📅 2026-07-25 🔺
```

- 優先度: 🔺高（今日・明日中）/ 🔸中（今週中）/ 🔹低（時間があれば）
- 期限記号: 📅 期限日 / ⏳ 予定日 / ✅ 完了日

## 5. タグ体系

```
#type/daily #type/survey #type/discussion #type/idea
#project/thesis #project/paperA
#topic/llm #topic/ml #topic/nlp
#status/draft #status/review #status/done
```

原則: 最低2つのタグ（`type` + `project` または `topic`）、階層は2-3段階まで、新規タグは既存タグで代用できないか確認してから。

## 6. コードブロック

言語指定を必ず付ける。必要なら `title="train.py" {3-5}` でファイル名・行番号を付与する。

## 7. コールアウト

```markdown
> [!NOTE] / [!WARNING] / [!TIP] / [!IMPORTANT] / [!QUESTION]
```

研究メモ用カスタム: `> [!HYPOTHESIS]`（仮説）/ `> [!RESULT]`（実験結果）/ `> [!TODO]`

## 8. 引用・出典

```markdown
Smith et al. (2024) は[[論文メモ-Smith2024|この論文]]で提案した手法により...

> "Large language models demonstrate..." [^smith2024]

[^smith2024]: Smith, J. et al. (2024). "Paper Title". Conference Name.
```

Webページは脚注に参照日を付ける: `[Obsidian Help](https://help.obsidian.md/) (参照: 2026-07-09)`

## 9. 日報テンプレート

```markdown
---
title: YYYYMMDD-日報
date: YYYY-MM-DD
tags:
  - type/daily
  - project/current-project
---

# YYYY年MM月DD日（曜日）日報

## 今日のタスク
### 完了 / ### 進行中 / ### 未着手

## 作業ログ
### 午前 / ### 午後

## メモ・気づき

## 関連メモ

## 明日の予定
```

## 10. 命名規則まとめ

| 要素 | ルール | 例 |
|-----|--------|-----|
| ファイル名 | `YYYYMMDD-種別-詳細.md` | `20260709-サーベイ-CoT.md` |
| 見出し | 日本語、簡潔に | `## 実験結果` |
| タグ | 小文字英語、階層構造 | `#topic/llm` |
| エイリアス | 文脈に合わせた自然な表現 | `[[Paper|この論文]]` |
