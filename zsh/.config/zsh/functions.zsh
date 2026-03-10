function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}


function fix_bluetooth() {
  sudo rmmod btusb
  sudo rmmod btintel

  sudo modprobe btintel
  sudo modprobe btusb
  echo "Bluetooth restarted."
}

function delete_stale_branches {
    force=false
    while getopts "f" opt; do
        case ${opt} in
        f)
            force=true
            ;;
        \?)
            echo "invalid option: -$optarg" 1>&2
            ;;
        esac
    done
    shift $((optind - 1))
    command_args="-d"
    if [ "$force" = true ]; then
        echo "forcing dangling branches deletion"
        command_args="-d"
    fi
    git fetch -p
    candidate_branches=$(git branch -vv | awk '/: desaparecido]/{print $1}')
    if [ -z "$candidate_branches" ]; then
        echo "no dangling branches to delete"
    else
        echo "$candidate_branches" | xargs git branch ${command_args}
    fi
}

function prune {
    git gc --aggressive --prune=all
}

function parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# === START integral ===
function change_fxi8_proxy() {
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

# === END integral ===
