fish_add_path ~/.local/bin

set -U fish_greeting

fish_vi_key_bindings
fish_config theme choose "Catppuccin Mocha"

abbr -a ls exa --icons
abbr -a l exa -l --icons
abbr -a ll exa -al --icons

if type -q bat
    abbr -a cat bat -p
else if type -q batcat
    abbr -a cat batcat -p
end

abbr -a gst git status
abbr -a gco git checkout
abbr -a ga git add
abbr -a gd git diff --ignore-all-space
abbr -a gdca git diff --cached --ignore-all-space
abbr -a gcm git commit -m
abbr -a gp git push
abbr -a gpl git pull

abbr -a n nvim .

abbr -a t tmux new -As

abbr -a di docker images
abbr -a dps docker ps -a
abbr -a dx docker exec -it
abbr -a dxr docker exec -it -u root
abbr -a dl docker logs
abbr -a dlt docker logs -fn 100
abbr -a dc docker-compose -f

function gig -d "Create a .gitignore file"
    curl -sL https://www.toptal.com/developers/gitignore/api/$argv
end

starship init fish | source
enable_transience

if type -q kubectl
    kubectl completion fish | source
end

fish_add_path $HOME/.cargo/bin
