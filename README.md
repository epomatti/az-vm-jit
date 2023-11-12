# Azure VM JIT access

Azure Virtual Machine (VM) with Just-in-Time access.

You'll need to enable [Microsoft Defender for Servers][1] for the Subscription.

Make sure you enable **Cloud Workload Protection (CWP)** for **Servers**. After that, install the agents using the Portal just for completeness.

Start by creating the sandbox infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

If everything goes right, the JIT policy will automatically be created to the VM by the Terraform AzApi provider.

Defender should have created the following `Deny` rule:

<img src=".assets/az-jit-deny.png" />

Now request your JIT access.

Defender should create the following `Allow` rule:

<img src=".assets/az-jit-allow.png" />

---

### Clean-up

Don't forget to disable Microsoft Defender if you're only testing.

Destroy the infrastructure:

```sh
terraform destroy -auto-approve
```


[1]: https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan

