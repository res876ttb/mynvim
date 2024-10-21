#!/bin/bash

# Configurations
NVIM_VERSION="0.10.2"

# Global variables
NVIM_INSTALLED_VERSION=""
INSTALL_NVIM=false
NVIM_INSTALL_ERR_MSG="Nelvim installation not start"
LAZYVIM_INSTALL_ERR_MSG="LazyNim installation not start"
MYNVIM_INSTALL_ERR_MSG="mynvim installation not start"

#############################
# Below is utilities function

verlte() {
  [ "$1" = "$(echo -e "$1\n$2" | sort -V | head -n1)" ]
}

verlt() {
  [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

check_exist_and_move() {
  file_to_move=$1
  file_move_to=$2

  if [[ -e $file_move_to ]]; then
    rm -rf $file_move_to
  fi

  if [[ -e $file_to_move ]]; then
    mv $file_to_move $file_move_to
  fi
}

install_nvim() {
  set -eE
  trap "echo Error occurs: \$NVIM_INSTALL_ERR_MSG" ERR

  NVIM_INSTALL_DIR=$HOME/.nvim/neovim-$NVIM_VERSION

  NVIM_INSTALL_ERR_MSG="Check dependencies -- make (used while compiling nvim)"
  which make >>/dev/null
  NVIM_INSTALL_ERR_MSG="Check dependencies -- make (used while compiling nvim)"
  which gcc >>/dev/null
  NVIM_INSTALL_ERR_MSG="Check dependencies -- ninja (used while compiling nvim)"
  which ninja >>/dev/null
  NVIM_INSTALL_ERR_MSG="Check dependencies -- cmake (used while compiling nvim)"
  which cmake >>/dev/null
  NVIM_INSTALL_ERR_MSG="Check dependencies -- unzip (used while compiling nvim)"
  which unzip >>/dev/null
  NVIM_INSTALL_ERR_MSG="Check dependencies -- gettext (used while compiling nvim)"
  which gettext >>/dev/null
  NVIM_INSTALL_ERR_MSG="Check dependencies -- curl (used while compiling nvim)"
  which curl >>/dev/null
  NVIM_INSTALL_ERR_MSG="Check dependencies -- npm (used by Mason)"
  which npm >>/dev/null

  NVIM_INSTALL_ERR_MSG="Clean existing neovim git repo"
  [[ -d "neovim_build" ]] && rm -rf neovim_build

  NVIM_INSTALL_ERR_MSG="Clone nvim git repo"
  git clone https://github.com/neovim/neovim -b v$NVIM_VERSION --depth=1 neovim_build
  cd neovim_build

  NVIM_INSTALL_ERR_MSG="Build nvim from source code"
  make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$NVIM_INSTALL_DIR -j8

  NVIM_INSTALL_ERR_MSG="Install nvim"
  make install

  NVIM_INSTALL_ERR_MSG="Create symlink for nvim to ~/.bin"
  [[ -d "$HOME/.bin" ]] && ln -s $NVIM_INSTALL_DIR/bin/nvim $HOME/.bin

  NVIM_INSTALL_ERR_MSG="Cleaning nvim source/compilation files"
  cd ../
  rm -rf neovim_build
  set +eE

  echo nvim has been compiled and installed to $NVIM_INSTALL_DIR
}

install_lazyvim() {
  set -eE
  trap "echo Error occurs: \$LAZYVIM_INSTALL_ERR_MSG" ERR

  LAZYVIM_INSTALL_ERR_MSG="Check dependencies -- gcc (used while installing nvim-treesitter)"
  which gcc >>/dev/null
  LAZYVIM_INSTALL_ERR_MSG="Check dependencies -- git (used for cloning lazyvim)"
  which git >>/dev/null
  LAZYVIM_INSTALL_ERR_MSG="Check dependencies -- nvim"
  which nvim >>/dev/null

  LAZYVIM_INSTALL_ERR_MSG="Backup current nvim setting"
  check_exist_and_move $HOME/.config/nvim /tmp/nvim.bak
  check_exist_and_move $HOME/.local/share/nvim /tmp/nvim.bak

  LAZYVIM_INSTALL_ERR_MSG="Git clone LazyVim to $HOME/.config/nvim"
  git clone https://github.com/LazyVim/starter $HOME/.config/nvim --depth=1
  rm -rf $HOME/.config/nvim/.git

  set +eE
}

install_mynvim() {
  set -eE
  trap "echo Error occurs: \$MYNVIM_INSTALL_ERR_MSG" ERR

  MYNVIM_INSTALL_ERR_MSG="Check dependencies -- git (used for cloning mynvim)"
  which git >>/dev/null
  MYNVIM_INSTALL_ERR_MSG="Check dependencies -- npm (used for installing LSP with Mason)"
  which npm >>/dev/null
  MYNVIM_INSTALL_ERR_MSG="Check dependencies -- fzf (used by telescope)"
  which fzf >>/dev/null
  MYNVIM_INSTALL_ERR_MSG="Check dependencies -- rg (used by telescope)"
  which rg >>/dev/null

  MYNVIM_INSTALL_ERR_MSG="Cloning mynvim"
  git clone https://github.com/res876ttb/mynvim .mynvim
  cd .mynvim

  MYNVIM_INSTALL_ERR_MSG="Copying configs"
  for i in $(find lua -print | grep "\.lua"); do
    cp $i $HOME/.config/nvim/$i
  done

  MYNVIM_INSTALL_ERR_MSG="Clean up mynvim installaion"
  cd ..
  rm -rf .mynvim

  set +eE
}

# Above is utilities function
#############################

# Skip installation if we already have latest neovim
if [[ "$(which nvim)" == '' ]]; then
  INSTALL_NVIM=true
else
  NVIM_INSTALLED_VERSION="$(nvim --version | grep NVIM | cut -d'v' -f 2)"
  verlt $NVIM_INSTALLED_VERSION $NVIM_VERSION && INSTALL_NVIM=true
fi

# Install Neovim
# [[ $INSTALL_NVIM == true ]] && install_nvim

# Install lazyvim
install_lazyvim

# Install custom configurations
install_mynvim

# Installation done!
echo mynvim installation is done!
