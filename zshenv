# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden --smartcase --glob --no-ignore "!.git/*"'

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

export PATH="$HOME/.rbenv/bin:$PATH"
