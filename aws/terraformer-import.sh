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
