#!/usr/bin/env bash

version="1.0.0"


scriptTemplateVersion="1.0.0"

# HISTORY:
#
# * DATE - v1.0.0  - 2024/07/24
#
# ##################################################

# Provide a variable with the location of this script.
readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


die() { echo "$*" 1>&2 ; exit 1; }



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
force=0
strict=0
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


function mainScript() {
############## Begin Script Here ###################
####################################################

echo -n

####################################################
############### End Script Here ####################
}


############## Begin Options and Usage ###################

# Print usage
usage() {
  echo -n "${0} COMMAND [OPTION]...

Short description

 Options:
  --force           Skip all user interaction.  Implied 'Yes' to all actions.
  -q, --quiet       Quiet (no output)
  -l, --log         Print log to file
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
    -h|--help) usage >&2; exit ;;
    --version) echo ${version}; exit ;;
    -v|--verbose) verbose=1 && shift;;
    -q|--quiet) quiet=1 && shift;;
    -d|--debug) debug=1 && shift;;
    --force) force=1 && shift;;
    *) usage >&2; exit ;;
  esac
done


############## End Options and Usage ###################




# ############# ############# #############
# ##                                     ##
# ##    NO NEED TO CHANGE ANYTHING       ##
# ##         BENEATH THIS LINE           ##
# ##                                     ##
# ############# ############# #############

# Trap bad exits with your cleanup function
trap trapCleanup EXIT INT TERM

# Exit on error. Append '||true' when you run the script if you expect an error.
set -o errexit

# Run in debug mode, if set
if [ "${debug}" == "1" ]; then
  set -x
fi

# Exit on empty variable
if [ "${strict}" == "1" ]; then
  set -o nounset
fi

# Bash will remember & return the highest exitcode in a chain of pipes.
# This way you can catch the error in case mysqldump fails in `mysqldump |gzip`, for example.
set -o pipefail

# Run your script
mainScript