# Obsidian記法ルール

## 概要

このドキュメントはObsidianでメモを作成・管理する際に従うべき記法ルールを定義します。

---

## 1. フロントマター（YAML）

すべてのメモにはフロントマターを付与する。

```yaml
---
title: メモのタイトル
date: 2025-01-19
tags:
  - research/survey
  - topic/llm
status: draft | in-progress | completed
related:
  - "[[関連メモ1]]"
  - "[[関連メモ2]]"
---
```

### 必須フィールド

| フィールド | 説明 | 例 |
|-----------|------|-----|
| `title` | メモのタイトル | `LLM推論手法のサーベイ` |
| `date` | 作成日（YYYY-MM-DD） | `2025-01-19` |
| `tags` | 分類タグ（配列） | `[research/survey]` |

### オプションフィールド

| フィールド | 説明 | 例 |
|-----------|------|-----|
| `status` | 進捗状態 | `draft`, `in-progress`, `completed` |
| `related` | 関連メモ | `["[[メモA]]", "[[メモB]]"]` |
| `due` | 期限 | `2025-01-31` |
| `priority` | 優先度 | `high`, `medium`, `low` |

---

## 2. 内部リンク

### 基本記法

```markdown
# 基本リンク
[[メモ名]]

# 表示テキスト付きリンク
[[メモ名|表示テキスト]]

# 見出しへのリンク
[[メモ名#見出し]]

# ブロックへのリンク
[[メモ名#^block-id]]
```

### リンク作成の原則

1. **関連概念は積極的にリンク**: 既存メモとの関連があれば必ずリンクを作成
2. **将来のメモへもリンク可**: 存在しないメモへのリンク（未作成リンク）も活用
3. **エイリアスの活用**: 文脈に合わせて表示テキストを変更

### 例

```markdown
今日は[[20250119-研究議論-ラボMTG|ラボMTG]]で[[LLM推論]]について議論した。
[[Chain-of-Thought]]の手法が有効という結論になった。
詳細は[[20250115-サーベイ-CoT#実験結果|CoTサーベイの実験結果]]を参照。
```

---

## 3. 数式

### インライン数式

```markdown
文中に $E = mc^2$ のように数式を埋め込む。
```

### ブロック数式

```markdown
$$
\mathcal{L} = -\sum_{i=1}^{N} y_i \log(\hat{y}_i)
$$
```

### 数式記法の原則

1. **簡単な数式**: インライン形式 `$...$`
2. **複雑な数式・重要な数式**: ブロック形式 `$$...$$`
3. **連番が必要な場合**: 手動で番号を付与

```markdown
$$
\nabla_\theta J(\theta) = \mathbb{E}_{\pi_\theta}[\nabla_\theta \log \pi_\theta(a|s) A^{\pi}(s,a)] \tag{1}
$$
```

---

## 4. タスク管理

### 基本記法

```markdown
- [ ] 未完了タスク
- [x] 完了タスク
- [-] キャンセルされたタスク
- [>] 延期されたタスク
- [?] 要確認タスク
```

### 拡張記法（メタデータ付き）

```markdown
- [ ] タスク内容 📅 2025-01-25 🔺
```

### 優先度記号

| 記号 | 意味 | 使用場面 |
|-----|------|---------|
| 🔺 | 高優先度 | 今日・明日中に対応必須 |
| 🔸 | 中優先度 | 今週中に対応 |
| 🔹 | 低優先度 | 時間があれば対応 |

### 期限記号

| 記号 | 意味 |
|-----|------|
| 📅 | 期限日 |
| ⏳ | 予定日 |
| ✅ | 完了日 |

### 例

```markdown
## 今週のタスク

- [ ] 論文のRelated Work執筆 📅 2025-01-22 🔺
- [ ] 実験コードのリファクタリング 📅 2025-01-24 🔸
- [x] サーベイメモの整理 ✅ 2025-01-18
- [ ] 次回MTGの資料準備 📅 2025-01-26 🔹
```

---

## 5. タグ体系

### 階層構造

```
#type/daily        # 日報
#type/survey       # サーベイ
#type/discussion   # 議論メモ
#type/idea         # アイデアメモ

#project/thesis    # 修論
#project/paperA    # 論文A

#topic/llm         # LLM関連
#topic/ml          # 機械学習全般
#topic/nlp         # 自然言語処理

#status/draft      # 下書き
#status/review     # レビュー中
#status/done       # 完了
```

### タグ付けの原則

1. **最低2つのタグ**: `type` と `project` または `topic`
2. **階層は2-3段階まで**: 深すぎると管理困難
3. **新規タグは慎重に**: 既存タグで代用できないか確認

---

## 6. コードブロック

### 言語指定

````markdown
```python
def hello():
    print("Hello, World!")
```
````

### ファイル名・行番号

````markdown
```python title="train.py" {3-5}
import torch

def train(model, dataloader):
    for batch in dataloader:
        loss = model(batch)
```
````

---

## 7. コールアウト（注釈ボックス）

### 基本記法

```markdown
> [!NOTE]
> 補足情報をここに記載

> [!WARNING]
> 注意事項をここに記載

> [!TIP]
> ヒントやコツをここに記載

> [!IMPORTANT]
> 重要事項をここに記載

> [!QUESTION]
> 疑問点や要確認事項
```

### 研究メモ用カスタムコールアウト

```markdown
> [!HYPOTHESIS]
> 仮説: ○○は△△に影響する

> [!RESULT]
> 実験結果: 精度が5%向上

> [!TODO]
> - [ ] 追加実験が必要
> - [ ] 論文を再読
```

---

## 8. 引用・出典

### 論文引用

```markdown
Smith et al. (2024) は[[論文メモ-Smith2024|この論文]]で提案した手法により...

> "Large language models demonstrate emergent abilities..." [^smith2024]

[^smith2024]: Smith, J. et al. (2024). "Paper Title". Conference Name.
```

### Webページ引用

```markdown
公式ドキュメント[^doc]によると...

[^doc]: [Obsidian Help](https://help.obsidian.md/) (参照: 2025-01-19)
```

---

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

### 完了
- [x] タスク1

### 進行中
- [ ] タスク2 🔺

### 未着手
- [ ] タスク3

## 作業ログ

### 午前
- 

### 午後
- 

## メモ・気づき

- 

## 関連メモ

- [[関連メモ]]

## 明日の予定

- [ ] 
```

---

## 10. 命名規則まとめ

| 要素 | ルール | 例 |
|-----|--------|-----|
| ファイル名 | `YYYYMMDD-種別-詳細.md` | `20250119-サーベイ-CoT.md` |
| 見出し | 日本語、簡潔に | `## 実験結果` |
| タグ | 小文字英語、階層構造 | `#topic/llm` |
| エイリアス | 文脈に合わせた自然な表現 | `[[Paper|この論文]]` |
