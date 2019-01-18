#!/bin/bash

# dotfiles path
DOTFILES_PATH="$HOME/dotfiles"

# Load utils
. $DOTFILES_PATH/setup/utils.sh


install_R() {
    print_title "R"
    print_message "Installing R..."
    wget https://cran.rstudio.com/bin/macosx/R-3.5.2.pkg
    sudo installer -pkg R-3.5.2.pkg -target /
    rm R-3.5.2.pkg
    print_success "successfully installed"
}

setup_R() {
    print_title".R directory..."
    dir=$HOME/.R; [ ! -e $dir ] && mkdir -p $dir
    dir=$HOME/.R/.library; [ ! -e $dir ] && mkdir -p $dir
    print_success "directory successfully created"
}

install_RStudio() {
    print_message "Installing RStudio..."
    wget https://download1.rstudio.org/RStudio-1.1.463.dmg
    sudo hdiutil attach RStudio-1.1.463.dmg
    sudo ditto "/Volumes/RStudio-1.1.463/RStudio.app" "/Applications/RStudio.app"
    sudo hdiutil detach /Volumes/RStudio-1.1.463
    rm RStudio-1.1.463.dmg
    print_success "successfully installed"
}

install_MeCab() {
    print_title "MeCab"
    print_message "Installing MeCab..."
    wget -O mecab-0.996.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE"
    tar zxfv mecab-0.996.tar.gz
    cd mecab-0.996
    ./configure
    make
    make check
    sudo make install

    print_message "Installing IPA dictionary..."
    wget -O mecab-ipadic-2.7.0-20070801.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM"
    tar -xzf mecab-ipadic-2.7.0-20070801.tar.gz
    cd mecab-ipadic-2.7.0-20070801; ./configure --with-charset=utf8; make; make install

    print_success "MeCab and IPA dic: successfully installed"
}


install_packages() {
    print_title "R packages"
    print_message "Installing R packages..."
    Rscript -e "install.packages('tidyverse')"
    Rscript -e "install.packages(c('devtools', 'githubinstall','tm','slam', 'tidytext', 'MlBayesOpt'))"
    Rscript -e "install.packages('RMeCab',repos='http://rmecab.jp/R')"
}

main(){
    install_R
    setup_R
    install_RStudio
    install_MeCab
    install_packages
}

main
