#!/bin/bash
# dystargate

function info() {
 echo -e "\033[1;34m$1 \033[0m"
}

function warn() {
 echo -e "\033[0;33m$1 \033[0m"
}

function error() {
 echo -e "\033[0;31m$1 \033[0m"
}

function usage() {
 info "Upgrade or install golang..."
 info "USAGE:"
 info "./go_install.sh GOVERSION"
 info "GOVERSION specify whcih is the golang version."
 info "----------------------------------------------"
}

# 安装go包管理工具
function InstallGvm(){
    cd ~
    GVMPATH=$HOME"/.gvm"
    if [ ! -d "$GVMPATH" ];
    then
        info "Install the gvm...."
        bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
        sed -i 's!https://go.googlesource.com/go!https://github.com/golang/go!g' $GVMPATH/scripts/install
        sed -i 's!https://go.googlesource.com/go!https://github.com/golang/go!g' $GVMPATH/scripts/listall
        echo "export GVM_ROOT=$HOME/.gvm"
    else
        info "YOU ALREADY INSTALL GVM"
    fi
    info "INSTALL GVM completed"
}

GOVERSION=$1

# 安装go版本
function InstallGoVersion(){

    gvm install $GOVERSION
    info "Install $GOVERSION as go version."

    # 创建GOPATH
    gopath=$HOME"/go"
    if [ ! -d $gopath ];
    then
        info "Create go workspace, include src,bin,pkg folder..."
        warn "Use $GOPATH as golang workspace..."
        mkdir $HOME"/go"
    else
        info "You already create GOPATH"
    fi

    # 声明变量
    if [ ! -z $GOPATH ];
    then
        echo "export GOPATH=$gopath"
        echo "export PATH=$PATH:$GOPATH/bin"
    else
        info "You already export GOPATH"
    fi
    info "Install completed."

}

# 升级go版本
function UpgradeGoVersion(){
    # TODO
    echo "gvm use $GOVERSION"
    echo `go version`
    info "Upgrade completed."
}

usage
sleep 1s
InstallGvm
InstallGoVersion
UpgradeGoVersion
