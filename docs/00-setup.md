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

We're going to use [VirtualBox][virtualbox] to host our virtual machine.
Follow the *Downloads* or click [here][virtualbox-download] then click the link
for *Windows hosts*.
This downloads the VirtualBox exe installer, open the exe, allow this app to
make changes to your device, and it should open the setup window.
Click *Next >*, accept all the defaults and click *Next >* again, click *Yes*,
click *Yes* again, then click *Install*.
You'll have to wait a bit as VirtualBox installs, afterwards leave the box
checked and click "Finish".

Now the go to the **VirtualBox** window and create your virtual machine by
following these steps:
1. Click *New* at the top of the window.
2. Fill out the *Name:* field with "Debian Testing", or whatever you'd like
   to name your virtual machine.
3. Click on the arrow to the right of *ISO Image:*, click *Other ...*, and
   select the Debian Testing ISO you downloaded. 
   The ISO should have a filename similar to `debian-testing-amd64-netinst.iso`.
   Click open and you should see the *ISO Image:* field filled in.
4. Click the *Skip Unattended Installation* checkbox to select it.
   You should see a message at the bottom that says *You have selected to skip
   unattended guest OS install, the guest OS will need to be installed
   manually.*.
5. Leave the rest of the defaults on this window and click *Next*.
6. Change the number of processors on this screen to at least "4", you can
   either drag the slider to the right of *Processors:* or input the number.
   Click the box next to *Enable EFI (special OSes only)* to check that option.
   Leave the *Base Memory:* field default for now, and click *Next*.
7. Leave the default *Create a Virtual Hard Disk Now* selected and increase
   the disk to "40.00 GB".
   You can leave *Pre-allocate Full Size* unselected and click *Next*.
8. The next screen is *Summary*, double-check your previous settings and
   click *Finish*.


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

When you use the virtual machine, if you find your mouse cursor stuck in the
VM, press **Right Ctrl** to get it back.

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
1. Select *Graphical install* by using the arrow keys (if it's not already
   selected), then press enter.
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
You'll either see the same screen as in step 1 or a login screen for your user.
If you see the same screen as step 1, we need to shut down the VM and remove the
ISO we used to install the operating system.

### Remove Debian Testing ISO

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">

VirtualBox automatically removes the installation media, so there's nothing to
do for this step.

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
After logging in press **Activities** in the top left, type "Terminal" then
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
That command just added your user to the group of trusted users that can use the
`sudo` command, you're all powerful now.
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
We've finished the basic setup for our virtual machine.

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

### Generate an SSH Key

<Tabs groupId="development-environment">
  <TabItem value="remote" label="Remote Development">

First, we'll have to install an SSH client and Git on your local machine.

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">

Install [Git for Windows][git] from [here][git-for-windows].
After installing Git, launch **Git Bash**, you'll run the remaining commands
from here.

  </TabItem>
  <TabItem value="mac" label="macOS">

Open a terminal by pressing **Cmd+Space**, typing "Terminal", and pressing
enter.
You should be able to type in the command `git --version` then press enter,
macOS will ask you if you'd like to install it if it's not already installed.
You'll run the remaining commands from here.

  </TabItem>
  <TabItem value="linux" label="Linux">

Ensure you have [Git][git] and an SSH client (likely OpenSSH).
You'll likely have to consult your distribution documentation for the proper
package names.
Open a terminal, we'll run the remaining commands from here.

  </TabItem>
</Tabs>

  </TabItem>
  <TabItem value="vm" label="Virtual Machine Development">

Open a terminal, if you've forgotten how press **Activities** in the top left,
type "Terminal" then press enter.
We already have all the tools we need, so that's all you have to do for this
step.
You'll run the remaining commands from here.

  </TabItem>
</Tabs>

Next, we're going to generate an SSH key.
Older guides may as you to generate an RSA key, but current best practices
suggest upgrading to Ed25519.
Generate your new key by typing the following command and pressing enter:

```
ssh-keygen -t ed25519
```

You can follow these steps:
1. Press enter to save your private key to the default location.
2. Enter a passphrase.
   **Enter a good passphrase and remember it.**
   This should be unique, and not shared with any other of your passwords.
   It's important to set this because even if you accidentally share your
   private key (which you should **NEVER** do), someone else would still need
   your passphrase to use it and pretend to be you.
   You should setup an SSH agent, so you don't have to constantly re-enter your
   passphrase.
   Also, you should use a password manager like [1Password][1password] (paid,
   and Canadian) or [Bitwarden][bitwarden] (free for personal use).
   If you'd like to ignore this warning, you can make it blank (as someone who
   has done this, trust me, you'll regret it).
3. Enter the same passphrase again to make sure you typed it correctly.

That's it!
You should get a message that your key was successfully created.
There's going to be two files generated: `id_ed25519`, and `id_ed25519.pub`.
`id_ed25519` is your private key, you should **NEVER** share this and be very
careful if you try to move it.
This key is your secure identity, you should be able to use this to access
multiple systems if you keep it safe.
`id_ed25519.pub` is your public key, you can share this, and in fact you should.
This public key matches with your private key.
You can share the public key, so other people know that data encrypted by your
private key was from you.
Type the following command and press enter:

```
cat ~/.ssh/id_ed25519.pub
```

Copy the result of this command, this is **your public key**.
You'll need it to access your code for the course.

### Setup GitLab

Make sure you login to [GitLab][gitlab] and can access it.
If you're using the virtual machine, you can use Firefox (press the Windows or
Command key and click the leftmost icon on the dock) to access the website
found at: https://laforge.eecg.utoronto.ca/.
If it takes too long to get access, please just ping Jon on Discord, likely
your information is not on Quercus yet.
Follow these steps to add your public key on GitLab:
1. Click your avatar near the top left (and over to the right a bit)
2. Click Edit profile
3. Click SSH Keys on the left
4. Add your public SSH key 
    1. Copy your public key (from running `cat ~/.ssh/id_ed25519.pub` in the
       terminal).
    2. Paste your public key into the "Key" text box on the site.
    3. (Optional) Give the key a title (it’ll be its name).
    4. Use the default "Usage type" and "Expiration date".
    5. Press the "Add key" button.

### Setup Remote Access

<Tabs groupId="development-environment">
  <TabItem value="remote" label="Remote Development">

We're also going to need to add the SSH key to our virtual machine.
Make sure your virtual machine is running, if it's not already.
Login to the virtual machine, open a terminal (if using the graphical
environment), and run the following command:

```
ip -br -4 addr
```

This will show you the IP address of your virtual machine, it's in the row
beginning with `enp`.
Your IP address is the number in the rightmost column, not including the slash
and numbers after.
It should be something like `192.168.64.3`, this is your VM's **IP**.
Switch back to the terminal on *your computer* (that you used to generate the
SSH key) and run the following command:

```
ssh-copy-id <USERNAME>@<IP>
```

Replace `<USERNAME>` with the username you set for your virtual machine, and
`<IP>` with the VM's IP address.
It should ask you for your user password you set on the virtual machine, enter
your password, and press enter.
You shouldn't have to use your user password for remote SSH access now, in
general password logins are less secure (mostly since people tend to pick bad
passwords).

Now, we're going to copy our SSH key (public and private) to the virtual
machine.
We need to do this because our virtual machine will communicate with the GitLab
server directly.
You could create another SSH key on the virtual machine and add that one to
GitLab instead (the one you already generated would just be used to connect to
your virtual machine).
However, we'll keep it simple and use the same key for both.
Type the following commands on *your machine* (replace `<USERNAME>` and `IP`
with the same information as before):

```
scp  ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub <USERNAME>@<IP>:~/.ssh/
```

Now, we're going to remote into the virtual machine and complete the next
section on the virtual machine.
Type the following command on your machine to remote into the virtual machine:

```
ssh <USERNAME>@<IP>
```

This should ask you for your passphrase, input it, and press enter.
Now the commands you type run on the virtual machine even though you're typing
them on your machine.
We're doing this mainly because we can copy and paste easier for the next
section (you could do the next section directly on the virtual machine if you'd
like).
For the next section type the commands here.

  </TabItem>
  <TabItem value="vm" label="Virtual Machine Development">
  
If you're developing on the virtual machine you don't need to do anything here.
Keep using your current terminal for the next section.

  </TabItem>
</Tabs>

### Clone Your Code Repository

Now that you're authorized to use GitLab, you can use Git to clone your
repository to your computer.
We're going to continue using the same terminal we used in the previous
sections.
If you haven't used Git before, it not only stores your source code.
Git stores the entire history of changes you make to your code, so as long as
you make checkpoints (through committing and pushing), you can always go back
to any previous version of your code.
If you haven't heard the terms committing and pushing before, please read
the [Git Book][git-book] (especially chapter 2).
In short, a "commit" creates a checkpoint of all your source files *on your
computer* (you can do this without internet).
A "push" makes sure your repository with all your checkpoints is the same as
the one on a server (you need internet to do this, and to ensure all your
changes are on GitLab).

Type the following commands, pressing enter after each line (replace
`<USERNAME>` with your username on GitLab, which is your UTORid):

```
cd ~
git clone git@laforge.eecg.utoronto.ca:ece344/2023-fall/<USERNAME>/ece344
cd ece344
git remote add upstream git@laforge.eecg.utoronto.ca:ece353/2023-fall/student/ece344
```

<Tabs groupId="development-environment">
  <TabItem value="remote" label="Remote Development">

Press **Ctrl+D** to logout of your virtual machine.
You can now close your terminal on your machine.
From this point on you shouldn't have to use the terminal on your local machine.

  </TabItem>
  <TabItem value="vm" label="Virtual Machine Development">
  
Keep the terminal open, you'll likely need it for the next section.

  </TabItem>
</Tabs>

### Install VSCode

<Tabs groupId="development-environment">
  <TabItem value="remote" label="Remote Development">

It's very likely you already have **VSCode** from your previous courses.
If you don't have it installed, please download and install it from
[here][vscode] using the instructions for your operating system.
Open VSCode, go to extensions, and download the **Remote - SSH** extension.

After installing the **Remote - SSH** extension, click on the arrows with a
green background in the lower left, and then click **Connect Current Window to
Host...**.
You'll see a text field at the top center of your VSCode window, enter
`<USERNAME>@<IP>` the same way you did when you setup remote access.
This should open a new window, click open on the splash screen or find it in
the menu.
You'll see another text field at the top center of this new VSCode window.
It should already say something like `/home/<USERNAME>/`.
Type `ece344` at the end (do not delete anything), and press enter.
This will open a new VSCode window (you can close the old one).
Whenever you need to work on the labs, this is what you'll use.
You just need to make sure your VM is active, and when you open VSCode again
you can reopen this environment in your recents (it'll say
`[SSH <USERNAME>@<IP>]` at the end).

  </TabItem>
  <TabItem value="vm" label="Virtual Machine Development">

Open Firefox (if it's not still open press the Windows or Command key and click
the leftmost icon on the dock), and go to the **VSCode** website [here][vscode].
If you're not using this site from the VM the URL is:
https://code.visualstudio.com/.
Click the "Download" link in the top right (do not try to download the package
from the landing site, it may be wrong).
In the middle column, under the Tux the penguin, download the **x64** version
of the **.deb** package.

:::note

If your machine is using Apple Silicon (newer 2021+ Macs), download the
**Arm64** version of the **.deb** package instead.

:::

Switch back to your terminal and type the following command:

```
cd ~/Downloads/
sudo apt install ./code_*
```

After this command completes, you'll have VSCode installed on your virtual
machine.
To launch VSCode, press the Windows or Command key, type "Visual", and press
enter.
You can also pin VSCode to the bottom dock by dragging it there before pressing
enter (that way you can just click on the icon on the dock instead of
searching).

In the VSCode window, go to "File", then "Open Folder...", select "ece344"
and press the open button in the top right of the window.
Click "Yes, I trust the authors".
This is your development environment, to get back to it just open VSCode
and reopen this folder in recents if it's not already open.

  </TabItem>
</Tabs>

Next go to extensions, and download the **clangd** extension from LLVM.
This extension adds code completion and easier code exploration.
Compared to Intellisense, clangd uses a real C++ compiler with the flags used
when you compile your code and is more accurate and better with larger
codebases.

You should open the terminal view in the bottom of VSCode by pressing
**Ctrl+`**.
Please close all other terminals, you'll only need the one within VSCode
from now on.
Everything you type in the terminal in VSCode will run on the virtual machine.

Now, we'll setup our Git options.
Type the following commands in this terminal window within VSCode:

```
git config --global user.name "Your Full Name"
git config --global user.email your@email.com
```

Replace `"Your Full Name"` and `your@email.com` with your information that
matches the GitLab server (your email should end with something similar to
`@mail.utoronto.ca`).
Next, we'll do some more Git settings, type the following commands:

```
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global alias.lol "log --pretty=oneline --abbrev-commit --graph --decorate"
```

These settings are few sanity options for Git and also gives you a nice command
to see the history of your repository visually, `git lol` in the terminal.
Try it now, this is useful to sanity check what's on the GitLab server and
what's on your machine (if the list is long you'll have to press "q" to quit
and regain control).
The line with `HEAD -> main` on it should be your latest commit, if that commit
is also available on the server you should see `origin/main` beside it.
Otherwise, anything above `origin/main` is not on the server, and the course
staff cannot see it (also your work is only on your machine so if something
bad happens you lose all your work).
To make sure all the latest changes are on the server use the `git push`
command.

Congratulations, that was quite a journey!
You used virtualization to install your own Linux operating system from scratch.
This is a rite of passage for any operating system course, and will serve you
well in your career.
Virtualization is very useful for software development, the first thing you'll
notice is that you're using the same operating system as the rest of your
friends and everything is consistent between you (no matter your actual
operating system).

## Part 3: Your First Kernel Module

```
sudo apt install linux-headers-$(uname -r)
```

```c title="hello.c"
#include <stdio.h>

int main() {
    return 0;
}
```

[debian-installer]: https://www.debian.org/devel/debian-installer/
[debian-amd64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso
[debian-arm64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/arm64/iso-cd/debian-testing-arm64-netinst.iso
[utm]: https://getutm.app/
[utm-app-store]: https://apps.apple.com/us/app/utm-virtual-machines/id1538878817
[utm-app]: https://github.com/utmapp/UTM/releases/latest/download/UTM.dmg
[virtualbox]: https://www.virtualbox.org/
[virtualbox-download]: https://www.virtualbox.org/wiki/Downloads
[git]: https://git-scm.com/
[git-for-windows]: https://git-scm.com/download/win
[1password]: https://1password.com/
[bitwarden]: https://bitwarden.com/
[gitlab]: https://laforge.eecg.utoronto.ca/
[git-book]: https://git-scm.com/book/en/v2
[vscode]: https://code.visualstudio.com/
