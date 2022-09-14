#!/bin/bash

expect -c "
spawn serverspec-init
expect \"Select number:\"
send \"1\n\"
expect \"Select number:\"
send \"1\n\"
expect \"Vagrant instance y\/n:\"
send \"n\n\"
expect \"Input target host name:\"
send \"3.115.185.117\n\"
expect "
