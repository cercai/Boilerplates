#!/usr/bin/env bash

version="1.0.0"


scriptTemplateVersion="1.0.3"

# HISTORY:
#
# * DATE - v1.0.3  - 2024/20/24
#
# ##################################################

# Provide a variable with the location of this script.
readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


die() { echo "$*" 1>&2 ; exit 1; }

# safeExit Function
# -----------------------------------
# Any actions that should be taken if the script ends correctly
# -----------------------------------
function safeExit() {

  if [ -d "${tmpDir}" ]; then
    rm -r "${tmpDir}"
  fi
  exit
}


# trapCleanup Function
# -----------------------------------
# Any actions that should be taken if the script is prematurely exited
# Call this function before anything else
# -----------------------------------
function trapCleanup() {
  echo ""
  if [ -d "${tmpDir}" ]; then
    rm -r "${tmpDir}"
  fi
  die "Exit trapped."
}


# Set Flags
# -----------------------------------
quiet=0
verbose=0
debug=0


# Set Temp Directory
# -----------------------------------
# Create temp directory with a random number.
# This directory is removed automatically at exit.
# -----------------------------------
tmpDir="$SCRIPT_DIR/tmp-$RANDOM/"
(umask 077 && mkdir "${tmpDir}") || {
  die "Could not create temporary directory! Exiting."
}


############## Begin Options and Usage ###################

# Print usage
usage() {
  echo -n "${0} [OPTION]...

Short description

 Options:

  -q, --quiet       Quiet (no output)
  -v, --verbose     Output more information. (Items echoed to 'verbose')
  -d, --debug       Runs script in BASH debug mode (set -x)
  -h, --help        Display this help and exit
      --version     Output version information and exit
"
}

# Print help if no argument is passed.
[[ $# -eq 0 ]] && set -- "--help"


# Read the parameters
while [[ $1 = -?* ]]; do
  case $1 in
    -h|--help) usage >&2; safeExit ;;
    -d|--debug) debug=1 && shift;;
    -v|--verbose) echo ${verbose}; safeExit ;;
    -q|--quiet) echo ${quiet}; safeExit ;;
    --version) echo ${version}; safeExit ;;
    *) usage >&2; safeExit ;;
  esac
done

############## End Options and Usage ###################


# Trap bad exits with your cleanup function
trap trapCleanup INT TERM

# Exit on error. Append '||true' when you run the script if you expect an error.
set -o errexit

# Run in debug mode, if set
if [ "${debug}" == "1" ]; then
  set -x
fi

# Exit on empty variable
set -o nounset

# Bash will remember & return the highest exitcode in a chain of pipes.
set -o pipefail

# ############# ############# #############
# ##                                     ##
# ##       WRITE YOUR SCRIPT HERE        ##
# ##                                     ##
# ############# ############# #############


safeExit