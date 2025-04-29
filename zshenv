# Some areas of these dotfiles are clones from the thoughtbot dotifles https://github.com/thoughtbot/dotfiles used under MIT. See https://github.com/thoughtbot/dotfiles/blob/master/LICENSE
# use vim as the visual editor
export VISUAL=nvim
export EDITOR=$VISUAL
export FORCE_NVIM_BUNDLES=1

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!.git/*"'

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

export PATH="$HOME/.rbenv/bin:$PATH"
