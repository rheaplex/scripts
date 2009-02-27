#!/bin/bash

# Copyright 2009 Rob Myers <rob@robmyers.org>
# Licenced under the GPL 3 or, at your option, any later version.

# Produce a Plucker version of Free Software, Free Society
# Some texinfo errors not fixed


# Convert eps images to GIFs

convert images/clib.eps images/clib.gif
convert images/code.eps images/code.gif
convert images/flex.eps images/flex.gif
convert images/free_software_song.eps images/free_software_song.gif
convert images/headMain.eps images/headMain.gif
convert images/party.eps images/party.gif
convert images/richard.eps images/richard.gif
convert images/philosophical-gnu.eps images/philosophical-gnu.gif


# Fix texinfo problems

perl -pe 's/@heading\{(.*)\}/@heading $1/' -i fs_for_freedom.texi 

perl -pe 's/^\\input texinfo_times.tex//' \
    -i rms-essays.texi

echo "\
@ifnottex
@alias unnumberedfootnote = footnote
@end ifnottex

@ifnottex
@macro sp1
@sp 1
@end macro
@end ifnottex

@include rms-essays.texi
" > rms-essays-html.texi


# Convert to plucker

makeinfo --html --no-headers --no-split --force -o rms-essays.html \
    rms-essays-html.texi

perl -pe 's/^(<a href="#.+)$/$1<br \/>/' \
    -i rms-essays.html

plucker-build --zlib-compression --stayonhost --bpp=1 --maxwidth=320 -p . \
    -f rms-essays -N "Free Software,Free Society" file://`pwd`/rms-essays.html
