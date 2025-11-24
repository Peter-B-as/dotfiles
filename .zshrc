# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(starship init zsh)"
# --- Peter Parker's VPN Switcher (Laptop Ver.) ---

# Tailscale モード（自宅鯖へのアクセス・同期用）
alias vpn-ts='echo "🕷️ Switching to Tailscale mode..." && mullvad disconnect && sudo tailscale up'

# Mullvad モード（カフェWi-Fi・調査用）
alias vpn-mull='echo "🕵️ Switching to Mullvad mode..." && sudo tailscale down && mullvad connect'

# ステータス確認
alias vpn-status='echo "--- Tailscale ---"; tailscale status; echo ""; echo "--- Mullvad ---"; mullvad status'
#Comment add
