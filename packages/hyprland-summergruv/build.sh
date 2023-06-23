#!/bin/sh

pkgname=$(grep "^pkgname=" PKGBUILD | awk -F"=" '{print $2}')
pkgrel=$(grep "^pkgrel=" PKGBUILD | awk -F"=" '{split($2,a," ");gsub(/"/, "", a[1]);print a[1]}')
arch=$(grep "^arch=" PKGBUILD | awk -F"'" '{print $2}')

#NEED ONLY TO EDIT  sourcefiles VARIABLE

sourcefiles="icons"

updpkgsums
#makepkg -g >> PKGBUILD
makepkg -f -scr --sign

pkgver=$(grep "^pkgver=" PKGBUILD | awk -F"=" '{print $2}')
pkgfile=$pkgname-$pkgver-$pkgrel-$arch.pkg.tar.zst
rm -rf src pkg $pkgname dots-hyprland 
rm -rf ../../$pkgfile ../../$pkgfile.sig

mv $pkgfile $pkgfile.sig ../../
