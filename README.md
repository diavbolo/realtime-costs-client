# realtime-costs-client


## Description

This repository is a lightweight Terraform module to be deployed on customer AWS accounts that grants access to fetch EC2 data so that can be calculated the costs in near real-time and used for downstream processes such as anomaly detection. For more information see [here](https://github.com/diavbolo/realtime-costs)
 
It creates an AWS role with and attaches a policy to allow access to EC2 description (only metadata, *"ec2:Describe\*"*). The resulting role grants access to a MWAA role placed in the main AWS account.
 
Last, it will report via an API endpoint when this has been successfully deployed or removed so that MWAA starts/stops scraping EC2 instance data.
 
 
## Requirements
 
- Terraform (tested with v0.15.4 and v1.1.2)
- curl + bash (tested on MacOS 12.0.1)
 
 
## Setup instructions
 
### Configure
 
1. Deploy [the main repository](https://github.com/diavbolo/realtime-costs)
2. `git clone` the current repository and create a new GitHub repository
3. Adjust the variables [here](https://github.com/diavbolo/realtime-costs-client/blob/master/variables.tf#L9) and [here](https://github.com/diavbolo/realtime-costs-client/blob/master/variables.tf#L13) based on the Terraform outputs after deploying the previous point
4. `git add+commit+push` the files to your new GitHub repository
 
Then your customers can start using this code to un/subscribe by cloning the new GitHub repository

### Subscribe

```
export TF_VAR_email="xxx@yyy.zzz" # customer email address
terraform init
terraform apply -auto-approve 
```

### Unsubscribe

```
export TF_VAR_email="xxx@yyy.zzz" # customer email address
terraform destroy -auto-approve 
```

### Notes

 1. Once deployed, don't delete the folder since the Terraform state is stored locally so that you can remove the deployment.
 2. If you have multiple profiles, copy the folder for each and set the appropiate one via `export AWS_PROFILE=profile_name`
 