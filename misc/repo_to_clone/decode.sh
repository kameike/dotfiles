#!/bin/sh

openssl aes-256-cbc -d -in clone.sh.encrypted -out clone.sh
