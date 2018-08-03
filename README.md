Laserswald's Dotfiles
=====================

You need GNU Stow in order to install these. Just put these in a subdirectory of ~, go into that directory and execute

    ./install [package]

for any package you want.

The packages you probably want include

- *core* : Basic home directory structure and environment setup.
- *sh* : Core shell script directory; compatible with any POSIX shell.
- *vim* or *emacs* : Editors.
- *xorg* : X configuration.

Special thanks goes to:
    arcetera for his ideas on how to structure my files.
    z3bra and dcat for being general badasses and making wmutils.

License:
I really don't care, but it would be nice if you credit me.

Language Support
----------------

### Shell

Shell script libraries are stored in `.local/lib/sh/` and must end in the suffix '.sh'. POSIX shell is required.

### AWK

Likewise, AWK script libraries are stored in `.local/lib/awk`.

### Lua

Lua dependencies are managed by LuaRocks.

### Scheme

Scheme libraries are in `.local/lib/scm` by default. They should end in .scm.
