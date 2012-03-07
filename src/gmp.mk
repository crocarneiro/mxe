# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# GMP
PKG             := gmp
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.0.4
$(PKG)_CHECKSUM := ea4ea7c3f10436ef5ae7a75b3fad163a8b86edc0
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.gmplib.org/
$(PKG)_URL      := ftp://ftp.gmplib.org/pub/$(PKG)-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_URL_2    := ftp://ftp.cs.tu-berlin.de/pub/gnu/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    wget -q -O- 'http://www.gmplib.org/' | \
    grep '<a href="' | \
    $(SED) -n 's,.*gmp-\([0-9][^>]*\)\.tar.*,\1,p' | \
    grep -v '^4\.' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && CC_FOR_BUILD=gcc ./configure \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-shared \
        --enable-cxx \
        --without-readline
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
