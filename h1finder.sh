#!/bin/bash

# Set your HackerOne API key
API_USERNAME="<your hackerone username>"
API_KEY="< Hackerone api key>"

# Retrieve list of programs
page=1
while [ true ]
do
  response=$(curl -X GET -u "$API_USERNAME:$API_KEY" -H "Accept: application/json" "https://api.hackerone.com/v1/hackers/programs/?page%5Bnumber%5D=$page&page%5Bsize%5D=100")
  if [ "$(echo $response | jq '.data | length')" -eq 0 ]
  then
    break
  fi
  echo "$response" | jq -r '.data[] | select(.attributes.offers_bounties == true) | .attributes.handle' >> programs.txt
  ((page++))
done

# Retrieve domains for each program
sort -u programs.txt -o programs.txt
while read -r handle
do
  response=$(curl -s -X GET -u "$API_USERNAME:$API_KEY" -H 'Accept: application/json' "https://api.hackerone.com/v1/hackers/programs/$handle" | jq -r '.relationships.structured_scopes.data[] | select(.attributes.asset_type == "URL" or select(.attributes.asset_type == "WILDCARD" and .attributes.eligible_for_submission == true) | .attributes.asset_identifier')
echo $response >> target.txt
echo $response
done < programs.txt
sort -u target.txt -o target.txt
cat target.txt | tr -s ' ' '\n' | sort -u | sed '/^$/d' > final.txt
rm target.txt
grep '*' final.txt > wild.txt
grep -v '*' final.txt > nonwild.txt
rm final.txt
sort -u wild.txt -o wild.txt
sed -i 's/,/\n/g' nonwild.txt
sed -i 's/,/\n/g' wild.txt
sort -u nonwild.txt -o nonwild.txt
sed -i 's/https:\/\///g' nonwild.txt
sed -i 's/http:\/\///g' nonwild.txt
sed -i 's|^|https://|' nonwild.txt
sed -i 's/https:\/\///g' wild.txt
sed -i 's/http:\/\///g' wild.txt

cat wild.txt
cat nonwild.txt
echo "."
echo "."
echo "."
echo "."
echo "BOTH FILES wild.txt AND nonwild.txt SAVED IN CURRENT DIRECTORY"
