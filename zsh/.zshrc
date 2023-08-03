HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch appendhistory histignoredups pushdignoredups
unsetopt beep

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source ~/.config/zsh/myzshalias.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/mykeybinds.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/z/z.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)


[ -f "/home/ulya/.ghcup/env" ] && source "/home/ulya/.ghcup/env" # ghcup-env
[ -f "/home/ulya/.cargo/env" ] && source "/home/ulya/.cargo/env" # ghcup-env

umask -S 077
