# Terraform Beginner Bootcamp 2023



## Semantic Versioning 2.0.0 :mage:

#### _<ins>This Terraform Bootcamp will be utilizing Semantic Versioning for its tagging.<ins>_ 



Given a version number **MAJOR.MINOR.PATCH**, increment the:

1. **MAJOR** version when you make incompatible API changes

2. **MINOR** version when you add functionality in a backward compatible manner

3. **PATCH** version when you make backward compatible bug fixes

> _For example: `1.0.0`_ 

### To know more about _Semantic Versioning_, please visit [**Official Website**](https://semver.org/) of Semver. 


## Installing Terraform CLI

Terraform is distributed as a binary package. In this bootcamp, we are going to use Ubuntu Linux and the given steps focuses on gpg keyring changes. 


**_[Step by Step guide to install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)_**


### Refactored Bash Scripts

We have specifically created a bash script to automate the process to _[install](./bin/install_terraform_cli.sh)_ Terraform CLI. Earlier Gitpod instruction has gpg keyring issue which we rectified in this bash script. 

1. Now you can manually run Terraform CLI install 
2. Gitpod yaml file is lot clearer and concise
3. Improve portability as other project can use it to install Terraform CLI without any issue


### Verifying Linux Distribution

As mentioned previously, we are going to use Ubuntu Linux for our Terraform bootcamp. It is important that we are able to determine which Linux distribution we are using regarless of Gitpod or any other online CDK. 

For that we use a simple Linux command to determine the Linux distribution: 

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

To know more about Linux distribution, you can visit the **[Website](https://opensource.com/article/18/6/linux-version)** for more info. 

#### Shebang Considerations</ul>

**[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))** has a special meaning and it starts with # (pound key) and ! (exclamation mark). This is used to specify which imterpreter will be used will run given the script. 

- `#!/bin/sh` – Execute the file using the Bourne shell, or a compatible shell, assumed to be in the /bin directory
- `#!/bin/bash` – Execute the file using the Bash shell
- `#!/usr/bin/pwsh` – Execute the file using PowerShell
- `#!/usr/bin/env python3` – Execute with a Python interpreter, using the env program search path to find it

Generally, for Bash script, we use `#!/bin/bash`. However, ChatGPT recommended another format i.e. `#!/usr/bin/env bash`
- Improve portability for different OS distributions 
- It will search the user's PATH for the bash executable



### Bash Script Execution Permission

Whenever we create a bash script file, we try to make it executable. Many of us use `./` infront of the script file. 

For example, in our bash script file, we execute it by 
```
$ ./bin/install_terraform_cli
```
However, the above script won't work because it doesn't have permission to execute to the script.  

Without giving the bash script script any permission, we can execute the aforemnetioned file as 
```
$ source ./bin/install_terraform_cli.sh 
```

Nonetheless, if you want to execute the bash script in a more convinient and traditional way `./bin/install_terraform_cli.sh`, you need to give the file permission to execute. 

There are two ways to achieve that: 

```sh
$ chmod u+x ./bin/install_terraform_cli
```
OR
    
```sh
$ chmod 744 ./bin/install_terraform_cli
```

Check this [Wikipedia](https://en.wikipedia.org/wiki/Chmod) page for more.

## Gitpod Lifecycle Execution

It is important to define `task` for ephemeral environment. Execution order for the **[Gitpod](https://www.gitpod.io/docs/configure/workspaces/tasks)** are `before`, `init` and `command`. The `init` command won't rerun if the existing workspace is restarted. 
 You can check [Gitpod.yml](.gitpod.yml) file and notice that we have used `before` whose execution order precedes `init` and `command`.   