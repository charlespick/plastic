#
#  check_whitespace.sh
#  development
#  Check files for whitespace problems
#  Adopted from the Klipper project
#
#  Copyright (C) 2018  Kevin O'Connor <kevin@koconnor.net>
#  This file may be distributed under the terms of the GNU GPLv3 license.
#

# Find SRCDIR from the pathname of this script
SRCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"
cd ${SRCDIR}

# Run whitespace tool on all source files
WS_DIRS="docs/ helpers/ src/ tests/"

# File types
WS_FILES="-name '*.py' -o -name '*.sh'" # helpers
WS_FILES="$WS_FILES -o -name '*.md'" # docs
WS_FILES="$WS_FILES -o -name '*.xctest' -o -name '*.swift'" # source

# Run
eval find $WS_DIRS $WS_EXCLUDE $WS_FILES | xargs ./helpers/check_whitespace.py
