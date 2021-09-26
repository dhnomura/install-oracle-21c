#!/bin/bash

declare -i valida=0
isInstalled() {
    if rpm -q $1 &> /dev/null; then
#        echo "$1 is installed - ok";
        return 0;
    else
#        echo "$1 is not installed - nok";
        yum install $1* -y
        valida=$valida+1
    fi
}
array=(bc
binutils compat-openssl10 elfutils-libelf
glibc
glibc-devel
ksh
libaio
libXrender
libX11
libXau
libXi
libXtst
libgcc
libnsl
libstdc++
libxcb
libibverbs
make smartmontools sysstat
jq
wget
unzip
curl
)
for i in "${array[@]}"
do
	isInstalled $i
done

if [ $valida -gt 0 ] ; then
    echo "Error - Please review the packages missing";
    exit 1;
else
    echo "OK - All packages are installed";
    exit 0;
fi
