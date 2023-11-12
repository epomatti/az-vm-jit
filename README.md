# Azure VM JIT access

Azure Virtual Machine (VM) with Just-in-Time access.

Start by creating the sandbox infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

You'll need to enable [Microsoft Defender for Servers][1] for the Subscription.

Make sure you enable **Cloud Workload Protection (CWP)** for **Servers**. After that, install the agents using the Portal just for completeness.




[1]: https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan

