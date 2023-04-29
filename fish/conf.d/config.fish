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
alias wtr='curl "wttr.in/Berlin?m"'
alias wtr2='curl "v2.wttr.in/Berlin?m"'

# system monitor
alias ptop='bpytop'
alias duf='duf --sort size'

# misc
alias rm='rm -i'
alias untar='tar -xf '
alias df-list='df -h -x squashfs'
alias ping='ping -c 5 '
alias wget='wget -c '

# when audio controls don't work
# alias audio-recovr='gsettings reset org.gnome.settings-daemon.plugins.media-keys volume-up && gsettings reset org.gnome.settings-daemon.plugins.media-keys volume-down && gsettings reset org.gnome.settings-daemon.plugins.media-keys volume-mute'

# for website
alias bundle-serve='bundle exec jekyll serve'
alias bundle-build='bundle exec jekyll build'

# # for radian interface to R
# alias r='radian'

# # search terminal history
# alias hgrep='history | grep --color=auto '

# fancy neofetch
alias neofency='neofetch | pv -qL 200 | lolcat -v 2'

# get window class
alias get-class='xprop | grep WM_CLASS'

# get window class
alias get-class='xprop | grep WM_CLASS'

# get window class
alias xborders='~/Downloads/programs/xborder/xborders'

# exa alias
alias ll='exa -hl' 
alias lg='exa --long --grid' 

# rstudio daily update
alias rstudio-daily='wget -P ~/Downloads/programs/ https://rstudio.org/download/latest/daily/desktop/jammy/rstudio-latest-amd64.deb && sudo nala install ~/Downloads/programs/rstudio-latest-amd64.deb && sudo rm ~/Downloads/programs/rstudio-latest-amd64.deb'

# for radian interface to R
# alias r="radian"