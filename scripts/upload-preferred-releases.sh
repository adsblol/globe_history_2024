#!/bin/bash
set -ex
# Copyright 2023 kat
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Depends on rclone + $REMOTE variable set to "remote:path"

# Get the PREFERRED_RELEASES
PREFERRED_RELEASES_LINK="https://raw.githubusercontent.com/adsblol/globe_history_2023/main/PREFERRED_RELEASES.txt"
PREFERRED_RELEASES=$(curl -fsL $PREFERRED_RELEASES_LINK)

# Each line is a .tar link, we get it, extract it and upload it to s3.

FULLDAYS=0
MAXFULLDAYS=3
for RELEASE in $PREFERRED_RELEASES
do
    # This line looks like this:
    # https://github.com/adsblol/globe_history_2023/releases/download/v2023.02.16-planes-readsb-test-0/v2023.02.16-planes-readsb-test-0.tar
    # Extract the filename from the link, etc

    FILENAME=$(basename $RELEASE) # v2023.02.16-planes-readsb-test-0.tar
    VERSION=$(echo $FILENAME | cut -d'-' -f1) # v2023.02.16
    DATE=$(echo $VERSION | cut -d'v' -f2) # 2023.02.16
    DATE_WITH_DASHES=$(echo $DATE | sed 's/\./-/g') # 2023-02-16
    DATE_WITH_SLASHES=$(echo $DATE | sed 's/\./\//g') # 2023/02/16
    REMOTE_PATH="$REMOTE/globe_history/$DATE_WITH_SLASHES"

    # If fulldays > 3, we stop
    if [ $FULLDAYS -gt $MAXFULLDAYS ]; then
        break
    fi
    # Chcek if there is any file already in $REMOTE_PATH, if there is, we need to skip
    rclone lsf $REMOTE_PATH/ | wc -l | grep -q 0 || FULLDAYS=$((FULLDAYS+1)) && continue

    # Download and untar at once
    X_DIR=$(mktemp -d)
    curl -fsL $RELEASE | tar -xf - -C $X_DIR
    rclone sync $X_DIR/ $REMOTE_PATH/ --progress --transfers 100 --checkers 100 --max-backlog 10000 --stats 1s --stats-one-line --stats-log-level NOTICE --log-level NOTICE --size-only

    rm -rf $X_DIR
done
