#!/usr/local/bin/fish

set -U fish_greeting ""

abbr -a ls exa
abbr -a l exa -l
abbr -a ll exa -al

if type -q bat
    abbr -a cat bat -p --paging=never
else if type -q batcat
    abbr -a cat batcat -p --paging=never
end

abbr -a gst git status
abbr -a gco git checkout
abbr -a ga git add
abbr -a gd git diff --ignore-all-space
abbr -a gdca git diff --cached --ignore-all-space
abbr -a gcm git commit -m
abbr -a gp git push
abbr -a gpl git pull

abbr -a di docker images
abbr -a dps docker ps -a

starship init fish | source

if type -q kubectl
    kubectl completion fish | source
end

if type -q fnm
    fnm completions --shell fish | source
    fnm env --use-on-cd | source
end
