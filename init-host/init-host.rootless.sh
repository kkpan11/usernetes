#!/bin/bash
set -eux -o pipefail

if [ "$(id -u)" == "0" ]; then
	echo "Must not run as the root"
	exit 1
fi

: "${CONTAINER_ENGINE:=docker}"
case "${CONTAINER_ENGINE}" in
"docker")
	dockerd-rootless-setuptool.sh install
	;;
"podman")
	systemctl --user enable --now podman-restart
	;;
*)
	# NOP
	;;
esac

${CONTAINER_ENGINE} info
