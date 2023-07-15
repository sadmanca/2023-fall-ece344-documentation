---
sidebar_position: 0
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Lab 0: Setup

After this starter lab you'll have a virtual machine, and have Git set up.

## Part 1: Creating Your Virtual Machine

We're going to install an operating system from scratch.

### Download Debian Testing ISO

We're going to install Debian, a distribution of Linux, specifically Debian
Testing.
Debian Testing is a Linux distribution known for its balance between stability
and access to newer software updates.
There are two other releases of Debian: Stable and Unstable.
Debian Stable uses older well tested software, while Debian Unstable has the
newest cutting edge software (which may have issues).
Ubuntu, another popular Linux distribution, originates from Debian.
So, if you know how to use Debian, you know how to use Ubuntu.

We're going to download the [Debian Installer][debian-installer].
The specific installer we're looking for is the **netinst CD images**.
If you're using an AMD or Intel CPU, download the **amd64** version of
the Live ISO [here][debian-amd64-iso].

:::note

If your machine is using Apple Silicon (newer 2021+ Macs), download the
**arm64** version of the Live ISO [here][debian-arm64-iso] instead.

:::

### Setup Virtual Machine

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">

Install **VirtualBox**.

  </TabItem>
  <TabItem value="mac" label="macOS">


We're going to use [UTM][utm] to host our virtual machine.
You do not need to pay for it, although if you want to support the developers
and get automatic updates you can get it on the [App Store][utm-app-store].
If you'd like the free version, please download it [here][utm-app].

Launch **UTM** and create your virtual machine by following these steps:
1. Click *Create a New Virtual Machine*
2. Click *Virtualize*
3. Click *Linux*
4. Under *Virtualization Engine*, leave *Use Apple Virtualization* unchecked.
   Under *Boot ISO Image*, click *Browse* and select the Debian Testing ISO
   you downloaded. The ISO should have a filename similar to
   `debian-testing-?????-netinst.iso`. Finally, click *Continue*.
5. You should be able to use the defaults for this *Hardware* screen, click
   *Continue*.
6. You can also use the defaults for this *Storage* screen, click *Continue*.
7. For *Shared Directory*, just click *Continue*.
8. The next screen is *Summary*, if you want you can rename your virtual machine
   to "Debian Testing", or whatever you'd like. Click *Save*.


  </TabItem>
  <TabItem value="linux" label="Linux">

Install **virt-manager**.

  </TabItem>
</Tabs>

### Installing Debian Testing

Now we're ready to install an operating system.
If you were doing this on your own computer you'd create a bootable USB flash
drive by copying the ISO and booting from USB.
The next steps are the same if you ever need to install a Linux operating system
on a computer.
However, since we're using a virtual machine, you don't need another computer or
USB flash drive.

Start your virtual machine, after a few seconds it should boot up.
After the machine boots, follow these steps:
1. Select *Graphical install* by pressing down arrow, then enter.
2. Select whichever language you'd like, then click *Continue*.
3. Select *Canada* for your location, then click *Continue*.
4. Unless you're used to different keymaps, select the default
   *American English*, and click *Continue*.
5. Wait a bit.
6. Next you'll select a hostname, you can choose whatever you want. You'll
   usually see it when using the terminal, you'll see `username@hostname`.
   You may want to choose something like `ece344-vm`.
   Click *Continue* after you've chosen a name.
7. For *Domain name*, you can leave it blank and click *Continue*.
8. Next, you'll set the root password. This password is very important on a real
   machine other people can use, since it would give them full access to do
   anything with it. However, since we're using a virtual machine, we don't care
   as much since our physical machine has security and control over the virtual
   machine. We're also not going to make this virtual machine accessible from
   the internet. You can use a simple password like `ece344`. Click *Continue*.
9. Fill out your full name and click *Continue*.
10. Pick a username, again, you'll see this in the terminal as
   `username@hostname`.
   You'll also use this username to login to the virtual machine.
11. Now, you'll set your user's password. You should always have a good password
    (and use a password manager!). Luckily for us, this is a virtual machine,
    so we can make it simple and fast.
    Pick something and click *Continue*.
12. Select the timezone, it should be *Eastern*, and click *Continue*.
13. Wait a bit more.
14. For partition disks, we'll keep it simple.
    Select *Guided - use entire disk* and click *Continue*.
15. Next we're going to select what drive we're going to install the operating
    system on.
    There should only be a single virtual drive in this case (on a real computer
    this would be a physical drive).
    Select the only drive and click *Continue*.
16. Keep the default *All files in one partition (recommended for new users)*
    and click *Continue*.
17. The next screen will give you a summary of what's going to happen to the
    drive. It's okay if this screen doesn't make any sense yet.
    Click *Continue*.
18. To make sure you really know what you're doing, you'll have to select
    *Yes* on this screen. The installer is double-checking with you before it
    reformats drive. If you're installing this on a physical drive, you want
    to make sure the drive doesn't have data you need on it, because this is the
    point of no return. After this step entire drive gets erased and replaced
    with Debian.
    Thankfully this is a virtual machine, so select *Yes* and click *Continue*.
19. Wait more.
20. Select *No* and click *Continue*.
21. Next, we're configuring the package manager. Select *Canada* and click
    *Continue*.
22. You can either keep the default, but *mirror.csclub.uwaterloo.ca* might be
    faster.
    Make your choice and click *Continue*.
23. We're not going to do anything fancy, click *Continue*.
24. Wait even longer.
25. Select whatever you want here, and click *Continue*.
26. Select *SSH server* and *standard system utilities* if they're not already
    checked by default.
    For a graphical environment (if you'd like to develop in the VM, and not
    remotely) also select *Debian desktop environment* and *GNOME*. As you can
    see there's lots of options to try after the course if you want.
    For now, click *Continue*.
27. Wait again.
28. We're finally done installing the operating system! Click *Continue*.

Now, the installer will reboot the virtual machine.
You'll likely see the same screen as in step 1.
We need to shut down the VM and remove the ISO we used to install the operating
system.

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">

Shut down VM.

  </TabItem>
  <TabItem value="mac" label="macOS">

Click on power button beside the "red yellow green" window controls.
Ignore the warning since we're not in our OS yet and click *OK*.
In the main UTM window (where you can see the virtual machines on the left
sidebar) select your virtual machine. Click *CD/DVD* at the bottom in the right
pane and click *Clear*. You can now hit the play button and boot your new
virtual machine.

  </TabItem>
  <TabItem value="linux" label="Linux">

Shut down VM.

  </TabItem>
</Tabs>

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

[debian-installer]: https://www.debian.org/devel/debian-installer/
[debian-amd64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso
[debian-arm64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/arm64/iso-cd/debian-testing-arm64-netinst.iso
[utm]: https://getutm.app/
[utm-app-store]: https://apps.apple.com/us/app/utm-virtual-machines/id1538878817
[utm-app]: https://github.com/utmapp/UTM/releases/latest/download/UTM.dmg
