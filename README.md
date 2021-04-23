## Downloads
DownloadsURL：https://www.terraform.io/downloads.html

website：https://registry.terraform.io/namespaces/hashicorp

Import Tool：https://github.com/GoogleCloudPlatform/terraformer

##### Environment variable
```bash
$ cat >/root/.bashrc< EOF
#terraform
export PATH=/usr/local/bin:$PATH
complete -C /usr/local/bin/terraform terraform
export TF_LOG_PATH=/var/log/terraform.log
EOF
```

## Configuration source
The foreign terraform source is used by default, and the domestic download is very slow。You can download the source first：https://releases.hashicorp.com/

## Example three clouds：

**Cloud**：AWS
- **Path**：.terraform/plugins/registry.terraform.io/hashicorp/aws/3.37.0/linux_amd64/terraform-provider-aws_v3.37.0_x5
- **Version**：3.37.0

##### Initial configuration
```bash
$ cat >init.tf< EOF
terraform {
  required_providers {
    aws = {
      version = "=3.37.0"
    }
  }
}
EOF
```

**Cloud**：Azure
- **Path**：.terraform/plugins/registry.terraform.io/hashicorp/azurerm/2.46.0/linux_amd64/terraform-provider-azurerm_v2.46.0_x5
- **Version**：2.46.0
```bash
$ cat >init.tf<EOF
terraform {
  required_providers {
    azurerm = {
      version = "=2.46.0"
     }
   }
}
EOF
```

**Cloud**：Aliyun
- **Path**：.terraform/plugins/registry.terraform.io/hashicorp/alicloud/1.121.2/linux_amd64/terraform-provider-alicloud_v1.121.2
- **Version**：1.121.2
```bash
$ cat >init.tf<EOF
terraform {
  required_providers {
    alicloud = {
      version = "=1.121.2"
     }
   }
}
EOF
```

**PS：You can put them together and associate them with soft connections**


## Terraformer Import Use

##### AWS 
- Environment variable
```bash
$ cat >/root/.bashrc< EOF
export AWS_ACCESS_KEY_ID="XXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXXXX"
EOF
```

- initialization terraform
```bash
$ mkdir aws
$ terraform init
```

- Scripting
```bash
$ cat >region.txt< EOF
us-east-1
us-east-2
us-west-1
us-west-2
af-south-1
ap-east-1
ap-northeast-3
ap-northeast-2
ap-southeast-1
ap-southeast-2
ap-northeast-1
ca-central-1
eu-west-1
eu-west-2
eu-south-1
eu-west-3
eu-north-1
me-south-1
a-east-1
```
```bash
$ cat >resource.txt< EOF
ec2_instance
eip
ebs
sg
s3
vpc
```
```
    $ cat >terraformer-import.sh< EOF
    #!/bin/bash
    RG=`cat region.txt`
    RS=`cat resource.txt`
    AWS_BIN=/opt/terraform/aws/.terraform
    for j in $RG;do
        for i in $RS;do
            terraformer-all import aws --resources=${i} --regions=$j -p ${j}/${i}
        ln -sf $AWS_BIN ${j}/${i}
        done
        echo $i
    done
    EOF
```
```
$ tree -d .
```
![](https://raw.githubusercontent.com/olddriver4/terraform-blog/main/images/aws-terraform-import.png)
```
$ terraform plan
$ terraform apply
```

##### Azure
- Environment variable
```bash
$ cat >/root/.bashrc< EOF
export ARM_SUBSCRIPTION_ID=XX
export ARM_CLIENT_ID=XX
export ARM_CLIENT_SECRET=XX
export ARM_TENANT_ID=XX
EOF
```
>ARM_SUBSCRIPTION ID   >Subscriptions id
 ARM_CLIENT_ID and ARM_CLIENT_SECRE      "azure >Azure Active Director >App registrations >Display name >Certificates & secrets >Client secrets"
ARM_TENANT_ID  >tenant id 

- initialization terraform
```bash
$ mkdir azure
$ terraform init
```

- Scripting
```bash
$ cat >resource.txt< EOF
disk
network_security_group
public_ip
resource_group
virtual_machine
```
```
$ cat >terraformer-import.sh< EOF
#!/bin/bash
RS=`cat resource.txt`
Azure_BIN=/opt/terraform/azure/.terraform
for i in $RS;do
    terraformer-all import azure --resources=${i} -p ${i}
    ln -sf $Azure_BIN ${i}/
done
```
```
$ tree -d .
```
![](https://raw.githubusercontent.com/olddriver4/terraform-blog/main/images/azure-terraform-import.png)
```
$ terraform plan
$ terraform apply
```

##### AliYun
- Environment variable
```bash
$ cat >/root/.bashrc< EOF
export ALICLOUD_ACCESS_KEY="XX"
export ALICLOUD_SECRET_KEY="XX"
EOF
```

- initialization terraform
```bash
$ mkdir aliyun
$ terraform init
```

- Scripting
```bash
$ cat >region.txt< EOF
cn-beijing
cn-zhangjiakou
cn-hangzhou
cn-hongkong
```
```bash
$ cat >resource.txt< EOF
ecs
sg
vpc
keypair
```
```
    $ cat >terraformer-import.sh< EOF
    #!/bin/bash
    RG=`cat region.txt`
    RS=`cat resource.txt`
    AliYun_BIN=/opt/terraform/aliyun/.terraform
    for j in $RG;do
        for i in $RS;do
            terraformer-all import alicloud --resources=${i} --regions=$j -p ${j}/${i}
        ln -sf $AliYun_BIN ${j}/${i}
        done
        echo $i
    done
    EOF
```
```
$ tree -d .
```
![](https://raw.githubusercontent.com/olddriver4/terraform-blog/main/images/aws-terraform-import.png)
```
$ terraform plan
$ terraform apply
```
## Write at the end

- Thanks for watching 
