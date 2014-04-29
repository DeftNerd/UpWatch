#!/bin/sh
#
# UpWat.ch Agent Installation Script
#
# @version		0.0.1
# @date			2014-04-31
#

# Set environment
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Prepare output
echo -e "|\n|   UpWatch Installer\n|   ===================\n|"

# Root required
if [ $(id -u) != "0" ];
then
	echo -e "|   Error: You need to be root to install the UpWat.ch agent\n|"
	exit 1
fi

# Parameters required
if [ $# -lt 2 ]
then
	echo -e "|   Usage: bash $0 'token' 'secret'\n|"
	exit 1
fi

# Attempt to delete previous agent
if [ -f /etc/upwatch/upwatch-agent.sh ]
then
	# Remove agent dir
	rm -R /etc/upwatch

	# Remove cron entry and user
	if id -u upwatch >/dev/null 2>&1
	then
		(crontab -u upwatch -l | grep -v "/etc/upwatch/upwatch-agent.sh") | crontab -u upwatch - && userdel upwatch
	else
		(crontab -u root -l | grep -v "/etc/upwatch/upwatch-agent.sh") | crontab -u root -
	fi
fi

# Create agent dir
mkdir -p /etc/upwatch

# Download agent
echo -e "|   Downloading upwatch-agent.sh to /etc/upwatch\n|\n|   + $(wget -nv -o /dev/stdout -O /etc/upwatch/upwatch-agent.sh --no-check-certificate https://raw.github.com/DeftNerd/UpWatch/master/upwatch-agent.sh)"

if [ -f /etc/upwatch/upwatch-agent.sh ]
then
	# Create auth file
	echo "$1 $2" > /etc/upwatch/upwatch-auth.log
	
	# Create user
	useradd upwatch -r -d /etc/upwatch -s /bin/false
	
	# Modify user permissions
	chown -R upwatch:upwatch /etc/upwatch && chmod -R 700 /etc/upwatch
	
	# Modify ping permissions
	chmod +s `type -p ping`

	# Configure cron
	crontab -u upwatch -l 2>/dev/null | { cat; echo "*/3 * * * * bash /etc/upwatch/upwatch-agent.sh > /etc/upwatch/upwatch-cron.log"; } | crontab -u upwatch -
	
	# Show success
	echo -e "|\n|   Success: The Upwatch agent has been installed\n|"
	
	# Attempt to delete installation script
	if [ -f $0 ]
	then
		rm -f $0
	fi
else
	# Show error
	echo -e "|\n|   Error: The Upwatch agent could not be installed\n|"
fi
