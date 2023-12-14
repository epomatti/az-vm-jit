# Azure VM JIT access

Azure Virtual Machine (VM) with Just-in-Time access.

You'll need to enable [Microsoft Defender for Servers][1] for the Subscription.

Make sure you enable **Cloud Workload Protection (CWP)** for **Servers**. After that, install the agents using the Portal just for completeness.

Start by creating the sandbox infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

The execution will fail with the following error:

```
'LinuxJITPolicy' is not onboarded to Defender For Servers offering.
```

Add the server to Defender and apply again to finish the setup.

If everything goes right, the JIT policy will automatically be created to the VM by the Terraform AzApi provider.

## JIT

Defender should have created the following `Deny` rule:

<img src=".assets/az-jit-deny.png" />

Now request your JIT access.

Defender should create the following `Allow` rule:

<img src=".assets/az-jit-allow.png" />

## PIM permissions

Here is a scenario for assignment of the `Security Administrator` Entra ID role.

The following users will be created:

| Name     | Member of      |
|----------|----------------|
| User1    | Group1         |
| User2    | Group2         |
| User3    | Group1, Group2 |

---

### Clean-up

Don't forget to disable Microsoft Defender if you're only testing.

Destroy the infrastructure:

```sh
terraform destroy -auto-approve
```


[1]: https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan

