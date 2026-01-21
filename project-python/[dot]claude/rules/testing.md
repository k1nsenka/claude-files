---
paths: "tests/**/*.py, **/*_test.py, **/test_*.py"
---

# テストルール

## 基本方針
- 主要機能のユニットテストを作成
- エッジケースを考慮
- テストが実行可能であることを確認

## ディレクトリ構成
- テストコードは `tests` ディレクトリ以下に配置
- `src` ディレクトリと同じ構成を維持

## テスト実行（uv使用）

### 基本実行
```bash
uv run pytest
```

### 詳細出力
```bash
uv run pytest -v
```

### 特定ファイル実行
```bash
uv run pytest tests/test_specific.py
```

### カバレッジ付き
```bash
uv run pytest --cov=src --cov-report=html
```

### 失敗時に停止
```bash
uv run pytest -x
```

## pytest追加（未インストールの場合）
```bash
uv add --dev pytest pytest-cov
```

## 完了条件
- テストコードを作成したら `uv run pytest` を実行してエラー無いことを確認
- エラーが出たら修正
- **すべてのテストが成功するまで徹底的に修正**
- 1つでも失敗があれば作業完了とみなさない

## モックの使用
- モックは最小限に留める
- 実際の機能テストを優先
