#!/bin/sh

if !(type go > /dev/null 2>&1); then
	echo "Need go env to run this script"
fi

if !(type dotfiles > /dev/null 2>&1); then
	echo "install dotfiles"
	go install github.com/rhysd/dotfiles@latest
fi

gopath=$(go env | grep ^GOPATH | sed 's/GOPATH="\(.*\)"/\1/g')
$gopath/bin/dotfiles link
