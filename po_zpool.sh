#!/bin/sh
#
# Copyright (c) 2022 Sean Davies <sean@city17.org>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE

po_token=
po_user=

die()
{
	echo "$1" 1>&2
	exit 1
}

usage()
{
	die "usage: ${0##*/} [-d] [-t title]"
}

while getopts dt: arg; do
	case ${arg} in
	d)	dflag=1 ;;
	t)	title=${OPTARG} ;;
	*)	usage ;;
	esac
done
shift $((OPTIND - 1))
[ "$#" -eq 0 ] || usage

if ! command -v curl >/dev/null; then
	die "${0##*/}: curl: command not found"
fi

if [ -z "${po_token}" ] || [ -z "${po_user}" ]; then
	die "${0##*/}: pushover varibles not defined"
fi

zpool_status=$(zpool status -x 2>&1)

if [ "${zpool_status}" != "all pools are healthy" ] || [ "${dflag:-0}" -eq 1 ]
then
	curl --show-error -w "\n" \
		--form-string "token=${po_token}" \
		--form-string "user=${po_user}" \
		--form-string "title=${title:-$(hostname)}" \
		--form-string "message=${zpool_status}" \
		https://api.pushover.net/1/messages.json
fi
