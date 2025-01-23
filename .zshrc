# Powerlevel10k Config
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# My Variables
# 检测 Linux 发行版并设置 LinuxDistributionId 变量
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    case $ID in
        ubuntu)
            LinuxDistributionId="ubuntu"
            ;;
        arch)
            LinuxDistributionId="arch"
            ;;
        debian)
            LinuxDistributionId="debian"
            ;;
        fedora)
            LinuxDistributionId="fedora"
            ;;
        centos)
            LinuxDistributionId="centos"
            ;;
        *)
            LinuxDistributionId="unknown"
            ;;
    esac
else
    LinuxDistributionId="unknown"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# AutoComplet Config
HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13

plugins=(
    git
    sudo
    you-should-use
    conda-env
    copypath
    copyfile
    #zsh-interactive-cd
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# My configuration

ZSH_THEME_CONDA_PREFIX='conda:%F{green}'
ZSH_THEME_CONDA_SUFFIX='%f'
RPROMPT='$(conda_prompt_info)'


# Conda Error With Openssl 3.0
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

if [[ $LinuxDistributionId == "arch" ]]; then

    __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/opt/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/opt/miniconda3/bin:$PATH"
        fi
    fi
else 
    __conda_setup="$('/home/paidax/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/paidax/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/paidax/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/paidax/miniconda3/bin:$PATH"
        fi                                                                                                                                                                                        
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias vi=vim

if [[ $LinuxDistributionId == "ubuntu" ]]; then
    # Ubuntu 特定的配置
    alias top=bottom
else
    alias top=btn
fi

alias cp=rsync
alias rsync="rsync --progress"
alias scrcpy="scrcpy --turn-screen-off --stay-awake"

alias ls="eza --icons"
alias tree="eza --tree --icons"

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

alias t='tgpt'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh-syntax-highlighting 作者建议手动安装，而不是使用框架或插件管理器
source /home/paidax/software/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# setup zoxide and instread of cd
if [[ $LinuxDistributionId == "ubuntu" ]]; then
    # Ubuntu 特定的配置
    export PATH="$PATH:/home/paidax/.local/bin" 
fi
eval "$(zoxide init zsh --cmd cd)"

# you-should-use Show in last line
export YSU_MESSAGE_POSITION="after"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
