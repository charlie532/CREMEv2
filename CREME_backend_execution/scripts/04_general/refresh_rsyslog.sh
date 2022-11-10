#!/usr/bin/expect -f
set delKnownHosts [lindex $argv 0]
set ip [lindex $argv 1]
set username [lindex $argv 2]
set password [lindex $argv 3]
set service_name [lindex $argv 4]

set timeout 180

# SSH connection
spawn /bin/bash $delKnownHosts
send "exit\r"
spawn ssh $username@$ip
expect "*continue connecting (yes/no*)? "
send "yes\r"
expect " password: "
send "$password\r"

expect "*:~# "
send "rm -r /var/log/dataset_generation/*\r"
expect "*:~# "
send "service $service_name restart\r"

expect "*:~# "
send "exit\r"
