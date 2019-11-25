#!/bin/bash
#set -o nounset
#set -o errexit

#
# Import the parameters required for the script:  $cli_User  $cli_User_pte_key
# Import the run_if_alive() function
#
[ ! -f ./actparms.conf ] && { echo "Usage: Missing config file ./actparms.conf "; exit 1; }
. ./actparms.conf

readonly TMPFILE="/tmp/$(basename -s .sh "$0").txt"
readonly numparms=1

[ $# -ne $numparms ] && { echo "Usage: $0 sky-ip (10.61.5.187) "; echo "Purpose: $0 lists all the workflows associated with an application on the Actifio appliance"; exit 1; }

act_ip=$1

cat > $TMPFILE <<EOT

echo "-------------------------------------------------"
udsinfo lsworkflow -nohdr -delim ^ | while IFS="^", read -r -a wflow ; do 
echo " "
echo "name: \${wflow[4]}"
appname=\`udsinfo lsapplication -nohdr -filtervalue id=\${wflow[6]} -delim ^ | cut -d ^ -f11\`
echo "  AppName: \$appname"
echo "  status: \${wflow[10]}"
done

exit
EOT

# Executes the list of Actifio CLI commands in the $TMPFILE file
run_act_cli_if_alive