---
name: research-intro
description: 構造化された研究論文イントロダクションの作成支援スキル。ユーザーが研究論文のイントロを作成する際に使用する。問題設定、既存技術、提案手法、実験の4つのセクションで構成された論文イントロを穴埋め形式でガイドする。「論文のイントロを書いて」「研究イントロを作成して」「Introduction作成」などのリクエストに対応。
---

# 研究論文イントロ作成スキル

穴埋め形式で構造化された研究論文イントロダクションを作成する。

## 構造概要

論文イントロは以下の構成要素で成り立つ：

1. **背景説明**（オプション）- 問題が一般的でない場合の導入
2. **類似問題の導入**（オプション）- 既知の問題から本論文の問題へ橋渡し
3. **本論文が解く問題**（必須）- 入力・出力・効果の明示
4. **既存技術**（必須）- 関連手法とその欠点
5. **提案手法**（必須）- 新手法の説明と効果
6. **実験**（必須）- 検証方法と結果

## 必要な入力情報

ユーザーから以下の情報を収集する：

### 基本情報（必須）
- `problem-input`: 問題の入力
- `problem-output`: 問題の出力（目標）
- `problem-benefit`: 得られる効果

### 提案手法（必須）
- `ours`: 提案手法の名称/概要（タイトルにも使用）
- `ours-detail`: 提案手法の詳細説明
- `ours-method1`: 手法1の説明（〜ので）
- `ours-effect1`: 効果1の説明

### 既存技術1（必須）
- `related1`: 既存技術1の名称
- `related1-detail`: 既存技術1の詳細
- `related1-drawback`: 既存技術1の欠点

### 実験（必須）
- `experiment-metric`: 評価指標

### オプション情報
- `ours-method2`, `ours-effect2`: 追加の手法と効果
- `ours-contribution`: 追加の貢献（理論解析など）
- `related2`, `related2-detail`, `related2-drawback`: 既存技術2
- `similar`, `similar-input`, `similar-output`, `similar-drawback`, `similar-drawbackcase`: 類似問題の導入
- `background`, `background-demand`: 背景説明
- `experiment-data`, `experiment-improvement`: 実験詳細

## 出力テンプレート

### タイトル
```
「{ours}」
```

### イントロ本文

**背景説明**（backgroundが存在する場合）:
```
{background}は、{background-detail}。しかし、{background}は、{background-drawback}という欠点を抱えている。そのため、{background-demand}が必要とされている。
```

**類似問題の導入**（similarが存在する場合）:
```
{similar}は、{similar-input}から{similar-output}を目指す問題であり、広く研究され、実応用も進んでいる。しかしながら、従来の{similar}には、{similar-drawback}という欠点があり、これは、{similar-drawbackcase}場合に致命的である。
```

**本論文が解く問題**（必須）:
```
[したがって、]{problem-input}から{problem-output}が可能になれば、{problem-benefit}という効果が得られる。
```

**既存技術**（必須）:
```
この問題に対する既存技術として、{related1}が知られている。{related1}は、{related1-detail}手法である。しかしながら、{related1}は、{related1-drawback}という欠点を抱えている。

[別の既存技術として、{related2}が知られている。{related2}は、{related2-detail}手法である。しかしながら、{related2}は、{related2-drawback}という欠点を抱えている。]
```

**提案手法**（必須）:
```
本論文は、{ours}を提案する。提案手法は、{ours-detail}手法である。

提案手法は、{ours-method1}ので、{ours-effect1}という効果を実現する。

[また、{ours-method2}ので、{ours-effect2}という効果を実現する。]

[さらに、我々は、{ours-contribution}を提供する。]
```

**実験**（必須）:
```
提案手法の有効性を確認するために、{experiment-data}を利用した数値実験を実施し、{related1}[及び{related2}]を含むベースラインと比較して提案手法が{experiment-metric}を最大{experiment-improvement}%改善することを確認した。
```

## 作成手順

1. ユーザーから研究内容をヒアリング
2. 必須項目を確認しながら情報収集
3. オプション項目の必要性を判断
4. テンプレートに沿ってイントロを生成
5. 妥当性チェック項目で整合性を確認

## 妥当性チェック項目

生成後、以下を確認：

- [ ] 背景/類似問題はML分野で認知されている概念である
- [ ] 問題設定の入力・出力・評価指標が一貫している
- [ ] 提案手法の説明が効果ではなく手法の説明になっている
- [ ] 提案手法と既存技術の差分が明確である
- [ ] 提案手法が既存技術の欠点を克服している
- [ ] 効果が手法から自明か、実験で裏付けられている
- [ ] 評価指標が出力の程度を直接定量的に評価している

## 注意事項

- このスキルは特定のタスクに対する新しい手法/アルゴリズム提案論文に有効
- 基礎理論系、証明テクニック提案、サーベイ論文には不向き
- 穴埋め形式のため表現が冗長になる場合があり、最終的な推敲が必要
- 引用の追加、行間の補足、表現の改善は別途必要
