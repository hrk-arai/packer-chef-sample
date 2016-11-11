aws ec2 run-instances \
--image-id $1 \
--instance-type t2.micro \
--subnet-id subnet-080f8951 \
--security-group-ids sg-e206cf85 \
--key h-arai \
--iam-instance-profile Name=s3-access-chef \
--user-data file://$2-$3-user-data.sh
