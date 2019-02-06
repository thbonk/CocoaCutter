#!/bin/sh
buildNumber=$(grep "^BUILD_NUMBER=" "$1" | cut -d'=' -f2)
buildNumber=$(($buildNumber + 1))
sed -i -e "s/^\(BUILD_NUMBER\s*=\s*\).*\$/\1$buildNumber/" $1

