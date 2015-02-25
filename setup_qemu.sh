#!/bin/sh

brew install pkg-config libtool
brew unlink qemu
brew uninstall qemu
brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
brew install qemu --env=std --cc=gcc-4.2
