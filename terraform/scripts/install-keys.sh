#!/bin/bash
while read -r line
do
    echo "$line" | sudo gitreceive upload-key user
done < <(cat /tmp/ssh-keys)
