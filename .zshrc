# Oh My Zsh setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="refined"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	fast-syntax-highlighting
	zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

# Load modular configs
for conf in ~/.zsh/*.zsh; do
	source "$conf"
done
