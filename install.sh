#!/bin/bash
# ~/.claude へ統一設定を展開するスクリプト
#
# - CLAUDE.md / rules / skills / agents はリポジトリへの symlink として配置
#   （リポジトリを編集すれば即座に全プロジェクトへ反映される）
# - settings.json は Claude Code 本体も書き込むため symlink にせず、
#   既存ファイルへ非破壊マージする（既存のキーは保持）
#
# 使い方: ./install.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_SRC="$REPO_DIR/home"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$CLAUDE_DIR/backups/pre-unify-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$CLAUDE_DIR"

link_item() {
    local src="$1" dst="$2"
    # 既に正しい symlink なら何もしない
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "OK(既設): $dst"
        return
    fi
    # 既存の実体はバックアップへ退避
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/"
        echo "退避: $dst -> $BACKUP_DIR/"
    fi
    ln -s "$src" "$dst"
    echo "リンク: $dst -> $src"
}

link_item "$HOME_SRC/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
link_item "$HOME_SRC/rules"     "$CLAUDE_DIR/rules"
link_item "$HOME_SRC/skills"    "$CLAUDE_DIR/skills"
link_item "$HOME_SRC/agents"    "$CLAUDE_DIR/agents"

# settings.json の非破壊マージ（既存キー優先・リストは和集合）
python3 - "$HOME_SRC/settings.json" "$CLAUDE_DIR/settings.json" <<'EOF'
import json, shutil, sys
from pathlib import Path

src_path, dst_path = Path(sys.argv[1]), Path(sys.argv[2])
src = json.loads(src_path.read_text())
dst = json.loads(dst_path.read_text()) if dst_path.exists() else {}

def merge(base, add):
    """add を base にマージする。dict は再帰、list は和集合、スカラーは base 優先。"""
    if isinstance(base, dict) and isinstance(add, dict):
        out = dict(base)
        for k, v in add.items():
            out[k] = merge(base[k], v) if k in base else v
        return out
    if isinstance(base, list) and isinstance(add, list):
        out = list(base)
        for item in add:
            if item not in out:
                out.append(item)
        return out
    return base  # 既存値を優先

if dst_path.exists():
    shutil.copy(dst_path, str(dst_path) + ".bak")
merged = merge(dst, src)
dst_path.write_text(json.dumps(merged, ensure_ascii=False, indent=2) + "\n")
print(f"マージ: {dst_path}（バックアップ: {dst_path}.bak）")
EOF

echo
echo "完了。すべての設定は ~/.claude（→ このリポジトリ）に統一されています。"
echo "プロジェクト側に .claude/ を作る必要はありません（プロジェクト固有の情報を書きたい場合のみ CLAUDE.md を作成）。"
