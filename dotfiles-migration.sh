#!/bin/bash

# 开启严格模式，遇到错误立即退出，并防止管道命令错误被忽略
set -euo pipefail

# --- 变量定义 ---
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSH_PLUGINS_DIR="$ZSH_CUSTOM/plugins"
EZA_REPO_URL="https://raw.githubusercontent.com/eza-community/eza/main/deb.asc"
EZA_REPO_FILE="/etc/apt/keyrings/gierens.gpg"
EZA_LIST_FILE="/etc/apt/sources.list.d/gierens.list"

# --- 函数定义 ---
install_zoxide() {
  echo "安装 zoxide..."
  if ! command -v zoxide &> /dev/null; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    echo "zoxide 安装完成!"
  else
    echo "zoxide 已安装，跳过安装。"
  fi
}

install_eza() {
    echo "安装 eza..."
    if ! command -v eza &> /dev/null; then
        sudo apt update
        sudo apt install -y gpg
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- "$EZA_REPO_URL" | sudo gpg --dearmor -o "$EZA_REPO_FILE"
        echo "deb [signed-by=$EZA_REPO_FILE] http://deb.gierens.de stable main" | sudo tee "$EZA_LIST_FILE"
        sudo chmod 644 "$EZA_REPO_FILE" "$EZA_LIST_FILE"
        sudo apt update
        sudo apt upgrade -y
        sudo apt install -y eza
        echo "eza 安装完成!"
    else
        echo "eza 已安装，跳过安装。"
    fi
}

install_plugin() {
    local plugin_name="$1"
    local repo_url="$2"
    local plugin_dir="$ZSH_PLUGINS_DIR/$plugin_name"

    echo "安装 $plugin_name 插件..."
    if [ -d "$plugin_dir" ]; then
        echo "$plugin_name 插件目录已存在，跳过克隆。"
    else
        git clone "$repo_url" "$plugin_dir"
        echo "$plugin_name 插件安装完成!"
    fi
}

# ---  主逻辑 ---

# 定义 dotfiles 别名
alias dotfiles="git --git-dir=$DOTFILES_DIR --work-tree=$HOME"

# 创建备份目录
mkdir -p "$BACKUP_DIR"
echo "备份目录已创建：$BACKUP_DIR"

# 尝试执行 dotfiles checkout
OUTPUT=$(dotfiles checkout 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "dotfiles 检出完成！"
    exit 0
fi

# 提取错误信息中以空白字符开头、以.开头的文件列表
UNTRACKED_FILES=$(echo "$OUTPUT" | egrep "^[[:space:]]+\." | awk '{print $1}')

if [ -z "$UNTRACKED_FILES" ]; then
    echo "未提取到待备份的文件，错误输出如下："
    echo "$OUTPUT"
    exit 1
fi

echo "检测到以下文件将被覆盖，准备备份："
echo "$UNTRACKED_FILES"

# 备份文件
echo "$UNTRACKED_FILES" | xargs -I {} sh -c '
    file=$(echo "{}" | sed "s/^[[:space:]]*//")
    if [ -e "$HOME/$file" ]; then
        if mv "$HOME/$file" "$BACKUP_DIR/"; then
            echo "已备份：$file"
        else
            echo "备份失败：$file" >&2
        fi
    else
        echo "文件不存在：$file" >&2
    fi
'

echo "备份完成，重新执行 dotfiles checkout..."
dotfiles checkout
if [ $? -eq 0 ]; then
    echo "dotfiles 检出成功！"
    echo "备份的文件保存在：$BACKUP_DIR"
else
    echo "dotfiles 检出仍然失败，请检查错误日志。" >&2
    echo "$OUTPUT" >&2 # 输出 Git 错误信息
fi

# --- 安装 zxide ---
install_zoxide

# --- 安装 eza ---
install_eza

# --- 安装 you should use ---
install_plugin "you-should-use" "https://github.com/MichaelAquilina/zsh-you-should-use.git"

# --- 安装 zsh-autosuggestions ---
install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"

echo "脚本执行完毕!"
