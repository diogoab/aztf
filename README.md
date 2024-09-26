# Sample manifests for creat resources at Azure

### requirements
- [terraform](https://developer.hashicorp.com/terraform/install)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [azcli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

## Azure - RG, VPC, Subnet, SG
- first check terraform.tfvars 

```
$ terraform init
$ terraform plan
$ terraform apply
$ terraform destroy
```
## Kubernetes - AKS
- first check terraform.tfvars 
- create ssh folder and key
#### provisioning 
```
$ terraform init
$ terraform plan
$ terraform apply
```

#### clear
```
$ terraform destroy
```

### Simple App
- first connect in azure
```
$ az login

$ az account set --subscription <YOUR-SUBSCRIPTION>

$ az aks get-credentials --resource-group <YOUR-RG> --name <YOUR-CLUSTER>

```
- Apply manifest
```
$ kubectl apply -f simple-app.yaml
```
- Clear
```
$ kubectl delete -f simple-app.yaml
```
