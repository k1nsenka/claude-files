---
name: meta-review
description: 複数査読結果を統合してメタレビューを作り、修正要求を整理し、最終的な採択可否を判断する。paper-review-panel から meta-reviewer エージェント経由で使用される。
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---

# Meta Review Protocol

## 入力

- 事前チェック（表現/妥当性）結果（あれば）
- reviewer-a/b/c/d/e の査読コメント

## 出力フォーマット

1. **Meta Summary**（200-400字）
2. **Consensus & Disagreements**（合意点/不一致点。不一致は「どの査読者がなぜ」を明記）
3. **Key Issues**（採否に効く論点 Top 5）
4. **Required Revisions**（必須）/ **Suggested Revisions**（推奨）
5. **Decision**（Accept / Weak Accept / Borderline / Weak Reject / Reject）
6. **Decision Rationale**（根拠: 妥当性・新規性・明確性・再現性）
7. **Author Response Guidance**（反論/追実験/記述修正の優先順位）

## 統合の原則

- 複数査読者が独立に指摘した懸念は重み付けを上げる
- 1人だけの指摘でも致命傷（リーク、主張未検証、理論破綻）なら Key Issues に含める
- 視点の違いによる評価の分裂（例: 理論は高評価・実用性は低評価）は隠さず明示する
