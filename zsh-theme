if [ `id -u` -eq 0 ]; then
    IND="%{$fg_bold[red]%}#%{$reset_color%} "
else
    IND='$ '
fi

USR="$(whoami)@"
if [ "$USR" = "joe@" ]; then
    USR=""
fi

PROMPT='
%{$fg_bold[grey]%}${USR}$(hostname) %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
${IND}'

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

