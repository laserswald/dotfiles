# scheme.sh -- add environment variables and paths for Scheme code

# Locally installed Scheme code is usually divided by implementation.
# However, I like to write a lot of Scheme, so I want to have some
# cross-implementation directories for my own stuff.

#
# R6RS
# 

export LAZR_LOCAL_LIBS=$HOME/.local/lib

export R6RS_LIB_DIRS=$LAZR_LOCAL_LIBS/r6rs

mkdir -p "$R6RS_LIB_DIRS"

CHEZSCHEMELIBDIRS="$R6RS_LIB_DIRS:$CHEZSCHEMELIBDIRS"
CHEZSCHEMELIBDIRS="/usr/local/lib/r6rs:$CHEZSCHEMELIBDIRS"
export CHEZSCHEMELIBDIRS

SRFI_HOME="$HOME/src/scheme-requests-for-implementation"
export SRFI_HOME

#
# R7RS
# 

export R7RS_LIB_DIRS=$LAZR_LOCAL_LIBS/r7rs

if test -z "$CHIBI_MODULE_PATH"; then
    CHIBI_MODULE_PATH="$CHIBI_MODULE_PATH:$R7RS_LIB_DIRS"
else
    CHIBI_MODULE_PATH="$R7RS_LIB_DIRS"
fi
export CHIBI_MODULE_PATH

