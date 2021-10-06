# Test Terraform and Ansible with AWS

## What is it for
This repo contains sample of usage ```Terraform``` and ```Ansible``` to deploy some infrastructure into Amazon cloud.
It will create such components as:
- SSH Bastion host
- Pack of ```Nginx```  server with static page, each in separate Avalability Zone
- Simple page for ```Nginx```
- Application Load Balancer
- VPC, Subnets, Route tables, NAT Gateways, Security zones, etc.

___
## Requirements
To run this scripts you will need at least this: 
- Terraform 1.0+
- Ansible core 2.10+
- Python 3.8+
- Jinja 2.10+
- Git
- AWS Secret Key file
- AWS Access Key file

___
## How to launch
1. First of all, clone this repo 
2. Then in ```varibles.tf``` fill the path to AWS keys
3. Change number of VPC, if you need
4. Initialize and run
    ```
    $ terraform init
    $ terraform apply --auto-approve
    ```
5. Test your infrastructure, with commands printed by ```output.tf```

___
## To do
 - [x] add README.MD
 - [ ] add Diagram of components
 - [ ] add Ansible roles
 - [ ] add some other fancy stuff