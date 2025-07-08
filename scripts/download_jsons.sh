#!/bin/bash
google_key=$1

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

SYSTEMS_URL="https://sheets.googleapis.com/v4/spreadsheets/1LgU7uJOtVOUWYkdoaeSbux41biFwpbzVosm98bgdN3k/values/Systems!A1:E3000?key=${google_key}"
MIA_URL="https://sheets.googleapis.com/v4/spreadsheets/1LgU7uJOtVOUWYkdoaeSbux41biFwpbzVosm98bgdN3k/values/MIA!A1:F3000?key=${google_key}"
GC_ISO_RVZ_URL="https://sheets.googleapis.com/v4/spreadsheets/1LgU7uJOtVOUWYkdoaeSbux41biFwpbzVosm98bgdN3k/values/gc-iso-rvz!A1:G4000?key=${google_key}"
WII_ISO_RVZ_URL="https://sheets.googleapis.com/v4/spreadsheets/1LgU7uJOtVOUWYkdoaeSbux41biFwpbzVosm98bgdN3k/values/wii-iso-rvz!A1:G4000?key=${google_key}"

cd $SCRIPT_DIR
cd ..
mkdir -p data
echo "Downloading Systems JSON file from Google Sheets..."
curl -s "${SYSTEMS_URL}" > ./data/systems.json
echo "Downloading MIA JSON file from Google Sheets..."
curl -s "${MIA_URL}" > ./data/mia.json
echo "Downloading GC ISO RVZ JSON file from Google Sheets..."
curl -s "${GC_ISO_RVZ_URL}" > ./data/gc-iso-rvz.json
echo "Downloading Wii ISO RVZ JSON file from Google Sheets..."
curl -s "${WII_ISO_RVZ_URL}" > ./data/wii-iso-rvz.json

python ./scripts/fix_json.py data/gc-iso-rvz.json
python ./scripts/fix_json.py data/wii-iso-rvz.json
exit 0