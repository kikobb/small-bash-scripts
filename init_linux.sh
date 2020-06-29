#!/bin/bash

# .profile #

#initialize PATH var in .profile 
cat << EOF >> ~/.profile
#-------------------#
# BEGIN CUSTOM INIT #

#add small-bash-scripts to $PATH
if [ -d "$HOME/bin/small-bash-scripts" ]; then
       PATH="$HOME/bin/small-bash-scripts:$PATH"
fi 

# END CUSTOM INIT #
#-----------------#
EOF

source ~/.profile


# .bashrc #

#create custom command line prompt look 
sed -i '/unset color_prompt force_color_prompt/c\#unset color_prompt force_color_prompt' ~/.bashrc
cat << EOF >> ~/.bashrc
#-------------------#
# BEGIN CUSTOM INIT #

#cusotm command prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@:\W\$ '
fi

#before delete foloving line uncomment same line on line 64
unset color_prompt force_color_prompt

# END CUSTOM INIT #
#-----------------#

EOF

#tldr
cat << EOF >> ~/.bashrc
#tldr located at ~/bin/small-bash-scripts
#enabling shell completition
complete -W "$(tldr 2>/dev/null --list)" tldr
EOF

source ~/.bashrc