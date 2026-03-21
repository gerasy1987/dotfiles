set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:/home/zhora/.local/bin

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

# for moving between directories
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'

# weather
alias wtr='curl "wttr.in/Nashville?m"'
alias wtr2='curl "v2.wttr.in/Nashville?m"'

# system monitor
alias duf='duf --sort size'

# misc
alias rm='rm -i'
alias untar='tar -xf '
alias df-list='df -h -x squashfs'
alias ping='ping -c 5 '
alias wget='wget -c '

# for website
alias bundle-serve='bundle exec jekyll serve'
alias bundle-build='bundle exec jekyll build'

# # search terminal history
# alias hgrep='history | grep --color=auto '

# get window class
alias get-class='xprop | grep WM_CLASS'

# exa alias
alias ll='exa -hl' 
alias lg='exa --long --grid' 

# for radian interface to R
alias r="radian"
