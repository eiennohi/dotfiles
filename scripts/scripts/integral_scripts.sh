#!/bin/bash

function change_fxi8_proxy {
    validServers=("top10","cqa","uat")

    if [ -z "$1" ]; then
        echo "You must provide a valid server ($validServers)."
        return
    fi
    
    if [[ " ${validServers[*]} " =~ "$1" ]]; then
        echo "Changing apache2 server to $1..."
        sudo cp "/etc/httpd/conf/extra/httpd-vhosts.$1.conf" "/etc/httpd/conf/extra/httpd-vhosts.conf"
        echo "Restarting apache..."
        sudo systemctl restart httpd.service
        echo "Done."
    else
        echo "Unknown server $1."
    fi
}

function vpn_start {
    sudo openconnect --syslog --timestamp --protocol=pulse --user=riveram https://cavpn.integral.com --useragent "Pulse-Secure/22.8.3.35577" --no-xmlpost
}
