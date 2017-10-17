


function version() {
	[ ! -f "/etc/debian_version" ] && \
	   echo "/etc/debian_version not found error" && exit 1

	VER=$(cat /etc/debian_version)
    VER=${VER:0:1}
    case $VER in
        '8')      echo "jessie";;
        '9')      echo "stretch";;
    esac
}