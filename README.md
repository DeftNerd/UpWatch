UpWat.ch Linux Agent
===============

The UpWat.ch agent collects selected server data and sends it to the UpWat.ch service. 
This agent was forked from nodequery/nq-agent to have a quick starting point. 

Requirements
------------

Most major distributions should work as long as they have the following utilities. 
The script has been successfully tested with newest versions of CentOS, Ubuntu,
Debian, Fedora and Arch Linux by the previous author. 

* coreutils
* crontab
* wget
* ip

Monitored Data
--------------

* Agent version
* System uptime
* Session count
* Process count
* OS kernel
* OS name
* OS architecture
* CPU identifier
* CPU cores
* CPU frequency
* RAM total
* RAM usage
* SWAP total
* SWAP usage
* Disk array
* Disk total
* Disk usage
* NIC identifier
* IPv4 address
* IPv6 address
* RX since boot
* TX since boot
* RX currently
* TX currently
* System load
* CPU load
* IO load
* Ping Europe
* Ping USA
* Ping Asia


Upcoming Data
------------
* Attempts to determine what virtualization platform, if any, the server is running on.
* File hash logging and monitoring
* Process Lists
* Detailed statistics on common services (nginx, apache, samba, mysqkm mariadb, postgresql, etc)
