#!/usr/bin/env sh

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# As such, the nature of the system is hard-coded
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached verson of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../texlive.profile

  cd ..
fi

# l3build itself and LuaTeX: need for texlua
tlmgr install l3build luatex

# Required to build plain and LaTeX formats:
# TeX90 plain for unpacking
tlmgr install cm etex knuth-lib latex-bin tex tex-ini-files unicode-data xetex

# Dependencies
tlmgr install   \
  geometry      \
  graphics      \
  ifluatex      \
  ifxetex       \
  amsmath       \
  lualatex-math \
  etoolbox      \
  filehook      \
  luaotfload    \
  fontspec      \
  oberdiek      \
  ucharcat

# Fonts
tlmgr install Asana-Math tex-gyre-math lm-math xits

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
