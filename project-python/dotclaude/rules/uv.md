---
paths: "pyproject.toml, uv.lock, **/*.py"
---

# uv ルール

## 基本方針
Pythonの環境管理・パッケージ管理には **uv** を使用する。
pip, venv, poetry, pipenv などは使用しない。

## プロジェクト初期化

### 新規プロジェクト作成
```bash
uv init project-name
cd project-name
```

### 既存プロジェクトでの初期化
```bash
uv init
```

## 仮想環境管理

### 仮想環境の作成（自動）
```bash
uv sync
```
※ `uv sync` で `.venv` が自動作成される

### Python バージョン指定
```bash
uv python install 3.12
uv python pin 3.12
```

## パッケージ管理

### パッケージ追加
```bash
uv add package-name
uv add "package-name>=1.0.0"
```

### 開発用パッケージ追加
```bash
uv add --dev pytest
uv add --dev ruff
uv add --dev mypy
```

### パッケージ削除
```bash
uv remove package-name
```

### 依存関係の同期
```bash
uv sync
```

### ロックファイル更新
```bash
uv lock
```

## スクリプト実行

### Pythonスクリプト実行
```bash
uv run python script.py
uv run python -m module_name
```

### pytest実行
```bash
uv run pytest
uv run pytest tests/ -v
```

### その他のツール実行
```bash
uv run ruff check .
uv run mypy src/
```

## 重要なルール

### 禁止事項
- `pip install` の使用禁止
- `python -m venv` の使用禁止
- グローバル環境へのインストール禁止

### 必須事項
- パッケージ追加時は必ず `uv add` を使用
- スクリプト実行は必ず `uv run` を使用
- `pyproject.toml` と `uv.lock` をGit管理する

### 作業開始時の確認
1. `uv sync` で依存関係を同期
2. `uv run python --version` でPythonバージョン確認
