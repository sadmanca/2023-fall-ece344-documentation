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

### Install Debian Testing

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
   the internet. You can use a simple password like `ece344`.
   You'll need to refer to this later, remember this is your **root password**.
   Click *Continue*.
9. Fill out your full name and click *Continue*.
10. Pick a username, again, you'll see this in the terminal as
   `username@hostname`.
   You'll also use this username to login to the virtual machine.
11. Now, you'll set your user's password. You should always have a good password
    (and use a password manager!). Luckily for us, this is a virtual machine,
    so we can make it simple and fast.
    Pick something, like your username again, and click *Continue*.
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
    remotely, see the beginning of Part 2 for some insight into the decision)
    also select *Debian desktop environment* and *GNOME*.
    As you can see there's lots of options to try after the course if you want.
    For now, click *Continue*.
27. Wait again.
28. We're finally done installing the operating system! Click *Continue*.

Now, the installer will reboot the virtual machine.
You'll likely see the same screen as in step 1.
We need to shut down the VM and remove the ISO we used to install the operating
system.

### Remove Debian Testing ISO

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">

Shut down VM.

  </TabItem>
  <TabItem value="mac" label="macOS">

Click on power button beside the "red yellow green" window controls in the top
left corner.
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

You may now delete the `debian-testing-?????-netinst.iso` file you downloaded.

### Install Software

Start your virtual machine and login using the user password you set earlier.
After logging in press **Activities** in the top left and type "Terminal" then
press enter.
This will open a terminal and give you access to a shell to run programs.
Right now our user can't do anything special, but we're going to change that.
Type the following and press enter:

```
su -
```

Type your **root password** and press enter.
You should now be logged in as the root user, which has access to do anything
to the operating system.
Generally you should never do anything as this user and instead ask for
permission.
We're going to allow our user we created during setup to do things as the root
user using the `sudo` command.
Right now, if you try to use `sudo` as your user you'll get an error like:
`<USERNAME> is not in the sudoers file.` where `<USERNAME>` is the username
you picked.
Let's make sure our user can use `sudo`; type the following command as the root
user:

```
usermod -aG sudo <USERNAME>
```

Instead of typing `<USERNAME>`, type the username you picked.
Congratulations, that command just added your user to the group of trusted
users that can use the `sudo` command.
While we're the root user, let's update the system.
Type the following command:

```
apt update
```

This will check all current software installed for updates.
Afterwards, it should say you have some updates available.
Type the following command to install the updates:

```
apt upgrade
```

This will tell you what software packages have updates and ask you if you'd like
to upgrade them.
Press `Y` to confirm and press enter.
Now we're running the latest software.
On Linux it's not necessary to reboot after updates, unless there's an update
to the kernel.
However, we may have updated the kernel, and we need to refresh our user
permissions, so we'll just reboot.
Type the following command:

```
reboot
```

After rebooting, login again and open another terminal.
We can now type `sudo` in the terminal and anything after that will run as
the root user (don't type `sudo` yet).
Try typing:

```
apt update
```

You'll get errors, the first one being that you don't have permission.
Try typing:

```
sudo apt update
```

Now it should work.
Common security practice is to disable the root user account for any outside
services (since if someone has access to the root account, they can do
anything).
Now, we're going to install the software we need for the course.
Type the following:

```
sudo apt install build-essential clang clangd git meson python3
```

Now we've installed the software that we'll be using in every lab.
We've finished the setup for our virtual machine.

## Part 2: Your Development Environment

You have two choices: remote development or virtual machine development.
I would highly recommend remote development as your workplaces will likely
require you to use it.
Remote development is required if you're using specialized or expensive hardware
(which is the case for AI).
It's slightly more involved, but you'll learn more and have more experience.
The other option is to develop inside the virtual machine.
The main drawback with using the virtual machine for development is that the
graphic acceleration is much slower, and trying to copy and paste between your
operating system and the virtual machine is a pain to set up.
For the following instructions, just like for your operating system, there are
tabs you can change depending on your choice.

### Install VSCode

<Tabs groupId="development-environment">
  <TabItem value="remote" label="Remote Development">

It's very likely you already have **VSCode** from your previous courses.
If you don't have it installed, please download and install it from
[here][vscode] using the instructions for your operating system.


**Remote**
First, find the IP of your virtual machine.


Install the **Remote - SSH** extension.

  </TabItem>
  <TabItem value="vm" label="Virtual Machine Development">

**Virtual machine**

  </TabItem>
</Tabs>


https://code.visualstudio.com/docs/remote/troubleshooting#_installing-a-supported-ssh-client

Press F1 and run the **Remote-SSH: Open SSH Host...*** command

### Generate an SSH Key

```
ssh-keygen -t ed25519
```

<Tabs groupId="development-environment">
  <TabItem value="remote" label="Remote Development">

**Remote**
First, find the IP of your virtual machine.

  </TabItem>
  <TabItem value="vm" label="Virtual Machine Development">

**Virtual machine**

  </TabItem>
</Tabs>

### Setup GitLab

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

## Part 3: Your First Kernel Module

```
sudo apt install linux-headers-$(uname -r)
```

[debian-installer]: https://www.debian.org/devel/debian-installer/
[debian-amd64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso
[debian-arm64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/arm64/iso-cd/debian-testing-arm64-netinst.iso
[utm]: https://getutm.app/
[utm-app-store]: https://apps.apple.com/us/app/utm-virtual-machines/id1538878817
[utm-app]: https://github.com/utmapp/UTM/releases/latest/download/UTM.dmg
[vscode]: https://code.visualstudio.com/
