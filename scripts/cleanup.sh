#!/bin/bash
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

# This script is supposed to check the available storage in /var/globe_history
# and delete the oldest files if the storage is getting low.
# The files look like: /var/globe_history/2023/01/03/...
# The script is supposed to delete the oldest days until the storage is below 50%.

# Get the current storage usage in percent
STORAGE=$(df -h /var/globe_history | tail -n 1 | awk '{print $5}' | sed 's/%//g')
YEAR=$(date +%Y)
# We check what is the oldest day
# Path should look like /var/globe_history/2023/01/03
function get_oldest_day {
    find /var/globe_history/ -maxdepth 3 -mindepth 3  -type d | sort | head -n 1
}

# We loop until the storage is below 50%
while [ $STORAGE -gt 50 ]; do
    OLDEST_DAY=$(get_oldest_day)
    # We check if the oldest day is the current day
    # If it is, we exit the loop
    if [ $OLDEST_DAY == "/var/globe_history/$YEAR/$(date +%m)/$(date +%d)" ]; then
        break
    fi
    # If path format is not /var/globe_history/[0-9]{4}/[0-9]{2}/[0-9]{2}, we exit the loop
    if ! [[ $OLDEST_DAY =~ ^/var/globe_history/[0-9]{4}/[0-9]{2}/[0-9]{2}$ ]]; then
        break
    fi
    # We delete the oldest day
    echo "Removing $OLDEST_DAY"
    rm -r $OLDEST_DAY
    # We update the storage usage
    STORAGE=$(df -h /var/globe_history | tail -n 1 | awk '{print $5}' | sed 's/%//g')
    echo "Storage usage is now $STORAGE%"
done
