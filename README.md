# Media Wiki Installation

## Install mediawiki using terraform

**Prerequisites:**
```
- AWS Access and Secret keys with required privileges
- Terraform plugin installed into the local machine
- AWS CLI installed in local system
- An backend s3 bucket be created in the AWS account for keeping .tfstate file
```
> ![](/files/readme_snips/S3_bucket.JPG)

## Implementation

 1. export aws credentials

```bash
# Linux

export AWS_ACCESS_KEY_ID=XXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXX

```

2. Generate a SSH key-pair(This is required at the time of ssh)

```bash
ssh-keygen -m PEM -t rsa -b 2048 -f mediawiki
```
3. Keep the private key with you and place the .pub key in the code lets ksay keep it at > ![](/files/key_pairs/mediawiki.pub)
4. Run `Terraform init` for initialization 

> ![](/files/readme_snips/init.PNG)

5. Run `terraform plan` it will show you the resources to be created, changed or deleted

> ![](/files/readme_snips/plan1.PNG)

> ![](/files/readme_snips/plan2.PNG)


6.  Run `terraform apply` to create the resources if everything looks good and pass an argument as `yes` to confirm.

> ![](/files/readme_snips/apply1.PNG)
> ![](/files/readme_snips/apply2.PNG)

7. Wait till your resources be created.


8. Once resources gets created use the `endpoint` provided by apply command to access the mediawiki home page for installation

> ![](/files/readme_snips/strings.PNG)

9. Select the language

> ![](/files/readme_snips/step1.PNG)


10. Fill DB related details

> ![](/files/readme_snips/step2.PNG)
> ![](/files/readme_snips/step3.PNG)
> ![](/files/readme_snips/step4.PNG)
11. Download LocalSettings.php file 

> ![](/files/readme_snips/local.PNG)

12. SSH to the EC2 machine using the pem key which you have kept with you in step no 2.(I am using session manager as I had already attached the ssm related policies to the IAM role of Instance profile of EC2 )

> ![](/files/readme_snips/step5.PNG)
> ![](/files/readme_snips/step6.PNG)

13. Copy the file to location `/var/www/html/mediawiki`. 

> ![](/files/readme_snips/step7.PNG)

14. Ones copied click onto `enter your wiki` link available onto page where php file is downloaded you will be redirected to your wiki

> ![](/files/readme_snips/step8.PNG)
> ![](/files/readme_snips/step9.PNG)

15. As this was only for demo purpose so after the activity destroy the infra.

> ![](/files/readme_snips/step10.PNG)

**Attributes:**
```
1. Created aws core infra module for basic platfor setup
2. I have created all the resources in us-west-1 region
3. Instead of hardcopying the ami id I have used data element.
4. Kept my EC2 in private subnet and added load balancer in public subnet.(EC2 will only allow load balancer to communicate to its port 80)
5. Used the SSM to connect to EC2. for this purpose added the respective policies to EC2 instance profile's IAM role.
```
**Issue:**
```
1. Were getting issue with AMI which I used for initial setup as presently It is not available so used the data element instead of hasrcoding.
```