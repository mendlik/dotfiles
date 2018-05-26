#!/bin/bash

# Default bashrc: /etc/skel/.bashrc
# ~/.bashrc: executed by bash for non-login shells.
# https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/
# http://serverfault.com/questions/261802/profile-vs-bash-profile-vs-bashrc

# Login Shell Startup Files:
# 1. /etc/profile
# 2. ~/.bash_profile OR ~/.bash_login OR ~/.profile (~/.bash_profile sources ~/.bashrc)
# 3. ~/.bash_logout

# Non-Login Shell Startup Files:
# 1. /etc/bash.bashrc
# 2. ~/.bashrc

# If not running interactively just exit
case $- in
  *i*) ;;
  *) return;;
esac

# Local variables
[ -r "$HOME/.bash_exports" ] && source "$HOME/.bash_exports"

# Defaults
: ${TMUX_FORCE:="$([ -x "$(command -v tmux)" ] && echo '1' || echo '0')"}
: ${ZSH_FORCE:="$([ -x "$(command -v zsh)" ] && echo '1' || echo '0')"}

# Force tmux
[ "$TMUX_FORCE" = 1 ] && [ -z "$TMUX" ] && export TERM=xterm-256color && exec tmux

if [ $SHLVL = 1 ] && [ "$ZSH_FORCE" = 1 ]; then
  # Force zsh
  exec zsh
else
  # bash_plugins=(jvm mvn-color !less)
  # ... or load them all
  source "$HOME/.bash/index.sh"
fi
