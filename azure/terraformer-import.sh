#!/bin/bash
RS=`cat resource.txt`
Azure_BIN=/opt/terraform/azure/.terraform

for i in $RS;do
    terraformer-all import azure --resources=${i} -p ${i}
    ln -sf $Azure_BIN ${i}/
done
