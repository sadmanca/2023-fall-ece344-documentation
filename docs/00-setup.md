---
sidebar_position: 0
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Lab 0: Setup

After this starter lab you'll have a virtual machine, and have Git set up.

## Part 1: Creating Your Virtual Machine

We're going to install an operating system from scratch.

TODO: Change to Ubuntu.

### Download Fedora ISO

https://fedoraproject.org/workstation/download/

Unless you have a machine using Apple Silicon, under
**For Intel and AMD x86_64 systems** download the Live ISO.
If you're using Apple Silicon, under **For ARM® aarch64 systems** download the
Live ISO.

### Install Virtualization Softare

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">
    I am Windows.
  </TabItem>
  <TabItem value="mac" label="macOS">
    I am macOS.
  </TabItem>
  <TabItem value="linux" label="Linux">

**TODO** Instructions
__ok__

  </TabItem>
</Tabs>

Setting up the Virtual Machine: Download and install your preferred virtualization software (VirtualBox recommended). Launch the application.

Creation of a New Virtual Machine: Click on "New" or "Create a new virtual machine". Name the VM (e.g., "Fedora VM"), choose 'Linux' as the type, and 'Fedora (64-bit)' as the version. Assign appropriate RAM and storage to your virtual machine.

Install Fedora: Download the Fedora ISO file from the official Fedora website. In your virtual machine settings, mount the downloaded Fedora ISO as a virtual disk. Start the virtual machine and follow the on-screen instructions to install Fedora.

Finalize Installation: Set up the root password, create a new user, and configure any other settings as needed.

## Part 2: Setting Up Your Development Environment

### Setting up GitLab

### Installing Software

```
sudo dnf install clang
```

https://laforge.eecg.utoronto.ca/

```c title="hello.c"
#include <stdio.h>

int main() {
    return 0;
}
```


## Part 3: C Debugging Practice

Now that you're set up on your new operating system it's time to rock.

```
cd debugging-practice
```

## Submission
