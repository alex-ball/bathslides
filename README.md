The bathslides class: University of Bath presentations
=========================================================

The bathslides LaTeX class is intended to produce slides for University
of Bath presentations, or an accompanying transcript, or both.
It is based on the [beamerswitch] class.

Internally, bathslides uses a presentation theme called 'Bath',
which can be used independently within beamer.

Installation
------------

### Pre-requisites ###

To use this theme, you will need to have the image files
`uob-logo-grey-transparent.pdf` and `uob-logo-white-transparent.pdf` (for PDF)
and `uob-logo-grey-transparent.eps` and `uob-logo-grey-transparent.eps` (for
DVI) somewhere TeX can find them.
I recommend you place them in the same folder as `bathslides.dtx`
while compiling the class and in a `tex/generic/logos-ubath` folder
thereafter.

The files are not distributed with the theme, firstly for licensing reasons
and secondly because access to them has been restricted to University of Bath
members. If you have a working set of credentials, you can download the EPS
files from the [University of Bath website][logo]; the two you need are listed
under "Slate grey" and "White" respectively.

To get the PDF versions, run `epstopdf uob-logo-grey-transparent.eps` and
`epstopdf uob-logo-white-transparent.eps` respectively. The `epstopdf` utility
is available in most TeX distributions.

The documentation uses fonts from the XCharter and sourcesanspro
packages, as well as sourcecodepro if XeLaTeX or LuaLaTeX is used,
or zi4 (inconsolata) otherwise. To compile the documentation
successfully, you will need the minted package installed and working.

### Automated way ###

A makefile is provided which you can use with the Make utility:

  * Running `make bathslides.cls` generates the derived files

      - README.md
      - bathslides.cls
      - beamerthemeBath.sty
      - beamerthemeBath2021.sty
      - bathcolors.sty
      - bathslides.ins
      - bathslides-sample-Bath.tex
      - bathslides-sample-Bath2021.tex

  * Running `make` generates the above plus

      - bathslides.pdf
      - bathslides-slides.pdf
      - uob-logo-grey-transparent.pdf
      - uob-logo-white-transparent.pdf

    You need to have downloaded `uob-logo-grey-transparent.eps` and
    `uob-logo-white-transparent.eps` to the working directory before
    running this. If you don't, Make will use Ghostcript (`gs`) to generate
    blank placeholder images to tide you over.

  * Running `make inst` installs the files (and images) in the user's
    TeX tree. (To undo, run `make uninst`.)

  * Running `make install` installs the files (and images) in the
    local TeX tree. (To undo, run `make uninstall`.)

The makefile is set up to use latexmk and lualatex by default.
If this causes difficulty you could change it to use pdflatex directly
instead.

### Manual way ###

To install the class from scratch, follow these instructions. If you have
downloaded the zip file from the [Releases] page on GitHub, you can skip the
first three steps.

 1. Run `etex bathslides.dtx` to generate the class and package files. (You can
    safely skip this step if you are confident about step 2.)

 2. Compile bathslides.dtx using your favourite version of LaTeX with shell
    escape enabled (as required by minted for typesetting the listings). You
    will also need to run it through `makeindex`. This will generate the main
    documentation (DVI or PDF).

 3. Compile bathslides.dtx a second time with `-jobname=bathslides-slides`
    as a command line option to generate the sample slides. Again, you will
    need to enable shell escape so that minted can mark up the code listings.

 4. Move the files to your TeX tree as follows:

      - `source/latex/bathslides`:
        bathslides.dtx,
        bathslides.ins
      - `tex/latex/bathslides`:
        bathcolors.sty,
        bathslides.cls,
        beamerthemeBath.sty,
        beamerthemeBath2021.sty,
        and the separately available image files as noted above
        (unless you have a better place to keep logos)
      - `doc/latex/bathslides`:
        bathslides.pdf,
        bathslides-slides.pdf,
        README.md

 5. You may then have to update your installation's file name database
    before TeX and friends can see the files.

Licence
-------

Copyright 2016 Alex Ball.

This work consists of the documented LaTeX file bathslides.dtx,
and a Makefile.

The text files contained in this work may be distributed and/or modified
under the conditions of the [LaTeX Project Public License (LPPL)][lppl],
either version 1.3c of this license or (at your option) any later
version.

This work is "maintained" (as per LPPL maintenance status) by
[Alex Ball][me].

[beamerswitch]: https://github.com/alex-ball/beamerswitch
[Releases]: https://github.com/alex-ball/bathslides/releases
[logo]: https://www.bath.ac.uk/guides/using-the-university-of-bath-logo/
[lppl]: http://www.latex-project.org/lppl.txt
[me]: http://alexball.me.uk/

