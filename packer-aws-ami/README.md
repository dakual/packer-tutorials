```sh
packer validate main.pkr.hcl
packer build main.pkr.hcl
packer build main.pkr.hcl 2>&1 | sudo tee output.txt
```