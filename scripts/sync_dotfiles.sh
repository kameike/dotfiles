#!/bin/sh

if !(type go > /dev/null 2>&1); then
	echo "Need go env to run this script"
fi

if !(type dotfiles > /dev/null 2>&1); then
	echo "install dotfiles"
	GO111MODULE=on go get github.com/rhysd/dotfiles
fi

gopath=$(go env | grep ^GOPATH | sed 's/GOPATH="\(.*\)"/\1/g')
$gopath/bin/dotfiles link
