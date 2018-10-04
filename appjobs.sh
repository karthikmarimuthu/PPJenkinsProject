#!/bin/bash
app=$JOB_NAME.$BUILD_ID
aws ec2 describe-instances | jq '.Reservations[].Instances[] | select(.Tags != null and .Tags[]=={"Key":"env","Value":"staging"} and .Tags[]=={"Key":"pp_type","Value":"APILITE"}).PrivateIpAddress' |tr -d '"' >> /tmp/auto/IPS-$app.txt
IFS=$'\n' read -d '' -r -a lines < /tmp/auto/IPS-$app.txt
printf "IN1=%s\n" "${lines[0]}" >> /tmp/auto/release-$app.txt
printf "IN2=%s\n" "${lines[1]}" >> /tmp/auto/release-$app.txt
echo "PPTYPE=APILITE" >> /tmp/auto/release-$app.txt
echo "MODULE=pricing-api" >> /tmp/auto/release-$app.txt
cat /tmp/auto/release-$app.txt
