# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#eval "$(starship init zsh)"
# --- Peter Parker's VPN Switcher (Laptop Ver.) ---

# Tailscale モード（自宅鯖へのアクセス・同期用）
alias vpn-ts='echo "🕷️ Switching to Tailscale mode..." && mullvad disconnect && sudo tailscale up'

# Mullvad モード（カフェWi-Fi・調査用）
alias vpn-mull='echo "🕵️ Switching to Mullvad mode..." && sudo tailscale down && mullvad connect'

# ステータス確認
alias vpn-status='echo "--- Tailscale ---"; tailscale status; echo ""; echo "--- Mullvad ---"; mullvad status'

#editor set
alias vi="nvim"
alias vim="nvim"

#dotfile
alias dot="cd ~/dotfiles"
alias dotpush="cd ~/dotfiles && git add . && git commit -m 'Update dotfiles' && git push"


# 「最強のドットファイル更新コマンド」
function dotup() {
    echo "📦 パッケージリストを更新中..."
    # 今入っているアプリ一覧を最新化して保存
    pacman -Qqe > ~/dotfiles/pkglist_native.txt
    pacman -Qqm > ~/dotfiles/pkglist_aur.txt
    echo "🚀 GitHubへ送信中..."
    cd ~/dotfiles
    git add .
    
    # コミットメッセージに日付を入れる（これで見返しやすくなる！）
    git commit -m "Update: $(date '+%Y-%m-%d %H:%M')"
    
    git push
    
    echo "✅ 完了！今日もいい仕事したね！"
}

alias mail-r="mbsync -a"
alias mail="mail-r && neomutt"
alias fullbackup='sudo /home/peter/wk/backup.sh && dotup'



# --- Peter Parker's VPN Switcher (Laptop Ver.) ---
# (中略) ... backup.sh && dotup' の下あたり

# SSH Agentの自動起動設定
# 常に固定のパスを環境変数にセットする
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# まだエージェントが動いていない（ソケットがない）時だけ起動する
if [ ! -S "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
  # 生成されたソケットを固定パスにシンボリックリンクする
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

alias gpu='nvtop -d 0.25'

# passコマンドは単にKeePassXCを呼ぶだけでOK（環境変数は上でセット済みだから）
# バックグラウンド実行(&)にしてターミナルを占有させない
alias pass="keepassxc > /dev/null 2>&1 &"

# Spider-Sense: Show system warnings and errors in real-time
alias sense='journalctl -f -p 4 -o cat | ccze -A'
