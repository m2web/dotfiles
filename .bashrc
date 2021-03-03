SSH_ENV=$HOME/.ssh/environment
 
# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
	 ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	    start_agent;
	}
else
    start_agent;
fi

force_color_prompt=yes

#place git branch name in prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#new line
new_line() {
     printf "\n$ "
}

#hard return symbol ↵
hard_return_symbol() {
     printf "\xE2\x86\xB5"
}

#mmcfadde@PC201485N ~/Documents/source/repos/API2ExcelReportConsoleApp (master) 2021-03-03 15:38:40 ↵
#$
# export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \[\033[1;34m\]\D{%F %T}\[\033[37m\] \$(hard_return_symbol)\$(new_line)"

#<<mmcfadde@PC201485N ~/Documents/source/repos/API2ExcelReportConsoleApp (master) 2021-03-03 15:45:16>>
#$
export PS1="<<\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \[\033[1;34m\]\D{%F %T}\[\033[37m\]>>\$(new_line)"
