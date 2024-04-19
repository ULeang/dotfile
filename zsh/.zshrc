HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch appendhistory histignoredups pushdignoredups noflowcontrol
setopt autopushd pushdignoredups pushdsilent
unsetopt beep

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
eval "$(starship init zsh)"
# eval "$(zoxide init zsh)"

source ~/.config/zsh/myzshalias.zsh
source ~/.config/zsh/completion.zsh
# source ~/.config/zsh/mykeybinds_vim.zsh
source ~/.config/zsh/mykeybinds_emacs.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/z/z.sh
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
