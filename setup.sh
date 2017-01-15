#!/bin/bash

# Variables
bash_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

# Mark files executables
chmod 700 "${bash_dir}/args.sh";

# Execute files
source "${bash_dir}/args.sh";


# chmod 700 "$DIR"/common-tools.sh
# chmod 700 "$DIR"/nodejs.sh
# chmod 700 "$DIR"/mongodb.sh
# chmod 700 "$DIR"/consul.sh

# "$DIR"/common-tools.sh
# "$DIR"/nodejs.sh
# "$DIR"/mongodb.sh
# "$DIR"/consul.sh