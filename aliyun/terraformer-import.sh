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
