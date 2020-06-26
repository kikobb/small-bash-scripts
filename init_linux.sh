#!/bin/bash

############
# .profile #
############
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