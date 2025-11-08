# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# PATH
export PATH="$HOME/.local/bin:$PATH"

# global alias
alias -g @c='| pbcopy'
alias -g @g='| grep'
alias -g @l='| less'
alias -g @m='| more'
alias -g @x='| xargs'

# sheldon
if command -v sheldon &> /dev/null; then
  eval "$(sheldon source)"
else
  echo "sheldon is not installed. Install it with:"
  echo "brew install sheldon"
fi

# completion
autoload -Uz compinit && compinit


# change 'ls' color
export LSCOLORS=Gxfxcxdxbxegedabagacad
alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -laG"


#>>>>>>>>> prompt style >>>>>>>>>>>>
export CLICOLOR=1

function left-prompt {
  name_t='179m%}'      # user name text clolr
  name_b='000m%}'    # user name background color
  path_t='255m%}'     # path text clolr
  path_b='031m%}'   # path background color
  arrow='087m%}'   # arrow color
  text_color='%{\e[38;5;'    # set text color
  back_color='%{\e[30;48;5;' # set background color
  reset='%{\e[0m%}'   # reset
  sharp='\uE0B0'      # triangle
  
  user="${back_color}${name_b}${text_color}${name_t}"
  dir="${back_color}${path_b}${text_color}${path_t}"
#  echo "${user}%n%#@%m${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}→ ${reset}"
  echo "${user}%n%#@%m${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset} "
}

PROMPT='$(left-prompt)' 

# start a new line by each command
function precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


# display git branch
function rprompt-git-current-branch {
  local branch_name st branch_status
  
  branch='\ue0a0'
  color='%{\e[38;5;'
  green='114m%}'
  red='001m%}'
  yellow='227m%}'
  blue='033m%}'
  reset='%{\e[0m%}'
  
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return
  fi
  
  branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  st=$(git status --porcelain 2> /dev/null)
  
  if [ -z "$st" ]; then
    # Clean working directory
    branch_status="${color}${green}${branch}"
  elif echo "$st" | grep -q "^??"; then
    # Untracked files
    branch_status="${color}${red}${branch}?"
  elif echo "$st" | grep -q "^ M"; then
    # Changes not staged
    branch_status="${color}${red}${branch}+"
  elif echo "$st" | grep -q "^M"; then
    # Changes staged
    branch_status="${color}${yellow}${branch}!"
  else
    branch_status="${color}${blue}${branch}"
  fi
  
  echo "${branch_status}$branch_name${reset}"
}
 
# Evaluate and replace the prompt string everytime the prompt is displayed.
setopt prompt_subst
 
# Show git branch on the right side of the prompt
RPROMPT='`rprompt-git-current-branch`'


# Slogan
echo "Learn or Die."

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

