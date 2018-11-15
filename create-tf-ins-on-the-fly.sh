#Build_Job
#Following script and then the deploy job
#!/bin/bash
app=$JOB_NAME.$BUILD_ID
echo "Name=$(echo $GIT_BRANCH | sed 's/[^PP]*//' | sed 's/_.*//')" >> /tmp/auto/release-$app.txt
source /tmp/auto/release-$app.txt
rm -fr /data/jenkins/TF_FILES/TEST-API/TEST-API-01.tf
cp /data/jenkins/workspace/Update_Terraform_Job/TEST-API/TEST-API-01.tf /data/jenkins/TF_FILES/TEST-API/
sed -i "s:TEST-API-01:$Name:" /data/jenkins/TF_FILES/TEST-API/TEST-API-01.tf
cd /data/jenkins/TF_FILES/TEST-API/
/data/jenkins/terraform/terraform init
/data/jenkins/terraform/terraform plan
/data/jenkins/terraform/terraform apply -auto-approve
source /tmp/auto/release-$app.txt
echo "PDNS=$(aws ec2 describe-instances | jq -r --arg Name "$Name" '.Reservations[].Instances[] | select(.Tags != null and .Tags[]=={"Key":"env","Value":"test"} and .Tags[]=={"Key":"Name","Value":$Name}).PrivateDnsName' |tr -d '"')" >> /tmp/auto/release-$app.txt
rm -fr /data/jenkins/TF_FILES/TEST-API/R53/r53.tf
cp /data/jenkins/workspace/Update_Terraform_Job/TEST-API/R53/r53.tf /data/jenkins/TF_FILES/TEST-API/R53/
source /tmp/auto/release-$app.txt
sed -i "s:INS_NAME:$Name:" /data/jenkins/TF_FILES/TEST-API/R53/r53.tf
sed -i "s:PDNS:$PDNS:" /data/jenkins/TF_FILES/TEST-API/R53/r53.tf
cd /data/jenkins/TF_FILES/TEST-API/R53/
/data/jenkins/terraform/terraform init
/data/jenkins/terraform/terraform plan
/data/jenkins/terraform/terraform apply -auto-approve
mkdir -p /data/jenkins/TF_FILES/DEL_R53/API-$(date +"%m%d%H")
cp -a /data/jenkins/TF_FILES/TEST-API/R53/r53.tf "/data/jenkins/TF_FILES/DEL_R53/API-$(date +"%m%d%H")/r53-API-$(date +"%m-%d-%y-%H-%M")".tf
source /tmp/auto/release-$app.txt
IN1=$(aws ec2 describe-instances | jq  -r --arg Name "$Name" '.Reservations[].Instances[] | select(.Tags != null and .Tags[]=={"Key":"env","Value":"test"} and .Tags[]=={"Key":"Name","Value":$Name}).PrivateIpAddress' |tr -d '"') >> /tmp/auto/release-$app.txt
echo "IP=$IN1" >> /tmp/auto/release-$app.txt
echo "PPTYPE=API" >> /tmp/auto/release-$app.txt
echo "MODULE=services" >> /tmp/auto/release-$app.txt
