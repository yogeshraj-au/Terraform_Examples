# Terraform_Examples

This repo contains configiuration of Terraform which will help to understand the basic syntax of terraform. 

1. Backend_Remote_state - This folder will create a s3 bucket and dynamo table to store the terraform state file in a remote storage and secured.

2. Count_argument - This folder explains about how count_argument can be used. It would be very helpful when we create to how many servers can be created rather than writing multiple resource block for each server.

3. Dev_Environment - This folder will create an EC2 Instance and store the terraform state file to s3 bucket. 

4. For_each - This folder explains about how for_each argument can be used.

5. Understanding_the_resource_block - This folder explains how a resource block can be defined and lifecycle block.

6. Understanding_the_variable_block - This folder will explain about how variables can be created and referenced in main.tf file. Please have a look at the variables.tf file to understand.