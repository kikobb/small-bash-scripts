#!/bin/bash

START_TAG="# -- BEGIN CUSTOM INIT (do not change)-- #"
END_TAG="# -- END CUSTOM INIT -- #"

# .profile #
PROFILE_PATH="$HOME/.profile"

#initialize PATH var in .profile 
# PROFILE=$("#add small-bash-scripts to $PATH
# if [ -d "$HOME/bin/small-bash-scripts" ]; then
#        PATH="$HOME/bin/small-bash-scripts:$PATH"
# fi
# ")

read -d '' PROFILE << 'EOM'
#add small-bash-scripts to $PATH
if [ -d "$HOME/bin/small-bash-scripts" ]; then
    PATH="$HOME/bin/small-bash-scripts:$PATH"
fi
EOM

IGNORE=false
CONFIGURED=false

while IFS= read -r LINE; do
	if [[ "$IGNORE" = true ]]; then
		if [[ "$LINE" == "$END_TAG" ]]; then
			IGNORE=false
		fi
	elif [[ "$LINE" == "$START_TAG" ]]; then
    	echo "$START_TAG" >> "$PROFILE_PATH"_tmp
    	echo "$PROFILE" >> "$PROFILE_PATH"_tmp
    	echo "$END_TAG" >> "$PROFILE_PATH"_tmp
    	IGNORE=true
    	CONFIGURED=true
    else	
    	echo "$LINE" >> "$PROFILE_PATH"_tmp
    fi
done < "$PROFILE_PATH"

if [[ "$CONFIGURED" = false ]]; then
	echo "$START_TAG" >> "$PROFILE_PATH"_tmp
    echo "$PROFILE" >> "$PROFILE_PATH"_tmp
    echo "$END_TAG" >> "$PROFILE_PATH"_tmp		
fi

mv "$PROFILE_PATH" "$PROFILE_PATH"_old
mv "$PROFILE_PATH"_tmp "$PROFILE_PATH"
rm -f "$PROFILE_PATH"_tmp

source ~/.profile

# .bashrc #

BASHRC_PATH="$HOME/.bashrc"
read -d '' BASHRC << 'EOM'
#cusotm command prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@:\W\$ '
fi

#before delete foloving line uncomment same line on line 64
unset color_prompt force_color_prompt

#tldr located at ~/bin/small-bash-scripts
#enabling shell completition
complete -W "$(tldr 2>/dev/null --list)" tldr
EOM

IGNORE=false
CONFIGURED=false

while IFS= read -r LINE; do
	if [[ "$IGNORE" = true ]]; then
		if [[ "$LINE" == "$END_TAG" ]]; then
			IGNORE=false
		fi
	elif [[ "$LINE" == "unset color_prompt force_color_prompt" ]]; then
			echo "#unset color_prompt force_color_prompt" >> "$BASHRC_PATH"_tmp
	elif [[ "$LINE" == "$START_TAG" ]]; then
    	echo "$START_TAG" >> "$BASHRC_PATH"_tmp
    	echo "$BASHRC" >> "$BASHRC_PATH"_tmp
    	echo "$END_TAG" >> "$BASHRC_PATH"_tmp
    	IGNORE=true
    	CONFIGURED=true
    else	
    	echo "$LINE" >> "$BASHRC_PATH"_tmp
    fi
done < "$BASHRC_PATH"

if [[ "$CONFIGURED" = false ]]; then
	echo "$START_TAG" >> "$BASHRC_PATH"_tmp
    echo "$BASHRC" >> "$BASHRC_PATH"_tmp
    echo "$END_TAG" >> "$BASHRC_PATH"_tmp		
fi

mv "$BASHRC_PATH" "$BASHRC_PATH"_old
mv "$BASHRC_PATH"_tmp "$BASHRC_PATH"
rm -f "$BASHRC_PATH"_tmp

source ~/.bashrc