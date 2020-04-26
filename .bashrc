# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case "$TERM" in
	xterm|screen) TERM=$TERM-256color ;;
esac

[ -z "$PS1" ] && return

PATH=${PATH}:~/bin

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    *color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

gitstatus()
{
	git status > /dev/null 2>&1
	if [ "$?" -eq "0" ]
	then
  		lANG=C git status | grep "nothing to commit" > /dev/null 2>&1
		if [ "$?" -eq "0" ]
		then
			# @4 - Clean repository - nothing to commit
			echo $(__git_ps1 " (%s)")
		else
		    # @5 - Changes to working tree
		    echo $(__git_ps1 " {%s}")
		fi
	else
	# @2 - Prompt when not in GIT repo
 		echo ""
fi
}

gitstatusColor()
{
	git status > /dev/null 2>&1
	if [ "$?" -eq "0" ]
	then
  		LANG=C git status | grep "nothing to commit" > /dev/null 2>&1
		if [ "$?" -eq "0" ]
		then
			# @4 - Clean repository - nothing to commit
			echo "32"
		else
		    # @5 - Changes to working tree
		    echo "31"
		fi
	else
	# @2 - Prompt when not in GIT repo
 		echo ""
fi
}

batcolor()
{
	bat="`acpi | grep -oE [0-9]\+% | head -c -2`"
	case $bat in
	100) sbat="[38;5;10m" ;;
	9[0-9]) sbat="[38;5;10m" ;;
	8[0-9]) sbat="[38;5;76m" ;;
	7[0-9]) sbat="[38;5;70m" ;;
	6[0-9]) sbat="[38;5;64m" ;;
	5[0-9]) sbat="[38;5;94m" ;;
	4[0-9]) sbat="[38;5;130m" ;;
	[2-3][0-9]) sbat="[38;5;1m" ;;
	1[0-9]) sbat="[38;5;160m" ;;
	[0-9]) sbat="[38;5;9m" ;;
	esac
	echo -n "$sbat"
}

batstatus()
{
	bat=`acpi | grep -oE [0-9]\+% | head -c -2`
	sbat=""
	box1="█"
	box2="▓"
	box3="▒"
	box4="░"
	box5=" "
	case $bat in
		100 | 9[0-9]) sbat="${sbat}${box1}${box1}${box1}" ;;
		9[0-9]) sbat="${sbat}${box1}${box1}${box2}" ;;
		8[0-9]) sbat="${sbat}${box1}${box1}${box3}" ;;
		7[0-9]) sbat="${sbat}${box1}${box1}${box4}" ;;
		6[0-9]) sbat="${sbat}${box1}${box1}${box5}" ;;
		5[0-9]) sbat="${sbat}${box1}${box2}${box5}" ;;
		4[0-9]) sbat="${sbat}${box1}${box3}${box5}" ;;
		3[0-9]) sbat="${sbat}${box1}${box4}${box5}" ;;
		2[0-9]) sbat="${sbat}${box1}${box5}${box5}" ;;
		1[6-9]) sbat="${sbat}${box2}${box5}${box5}" ;;
		1[0-5]) sbat="${sbat}${box3}${box5}${box5}" ;;
		[6-9]) sbat="${sbat}${box4}${box5}${box5}" ;;
		[0-5]) sbat="${sbat}${box5}${box5}${box5}" ;;
	esac
	echo "$sbat"
}

cpu_temp(){
	TEMP=`vcgencmd measure_temp | cut -d'=' -f2 | grep -oP '[\d\.]+'`
	echo ${TEMP}
}

cpu_color() {
	TEMP=`vcgencmd measure_temp | cut -d'=' -f2 | grep -oP '[\d\.]+'`
	if (( $(echo "$TEMP > 60" | bc -l) )); then
		echo "[33m"
	elif (( $(echo "$TEMP > 70"  | bc -l) )); then
		echo "[31m"
	else
		echo "[32m"
	fi
}

onBat="no"
acpi > /dev/null 2>&1
if [ $? -eq 0 ]
then
	if [ "`acpi`" ]
	then
		onBat="yes"
	fi
fi

if [ "$color_prompt" = yes ]; then
	hc="34"
	cUSER="38;5;202"
	cPATH="38;5;102"
	cTIME="35"
	PS1="[\[\033[${cTIME}m\]\t\[\033[m\]][\[\e\`cpu_color\`\]\`cpu_temp\`\[\e[0m\]] \` if [ \$? = 0 ]; then echo \[\e[32m\]:\)\[\e[0m\]; else echo \[\e[31m\]:\(\[\e[0m\]; fi\` \[\033[${cUSER}m\]\u\[\033[0m\]@\[\033[${hc}m\]\h\[\033[0m\]:\[\033[${cPATH}m\]\W\[\033[0m\]\$ "	
else
	PS1="[\t] \` if [ \$? = 0 ]; then echo \[\e[32m\]:\)\[\e[0m\]; else echo \[\e[31m\]:\(\[\e[0m\]; fi\` \u@\h:\W$ "
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export QT_IM_MODULE=xim
export GTK_IM_MODULE=xim
export EDITOR=vim
export _JAVA_AWT_WM_NONREPARENTING=1
