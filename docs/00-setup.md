---
sidebar_position: 0
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Lab 0: Setup

In this starter lab, you'll build a Virtual Machine (VM), install an operating
system, and set up your programming tools with VSCode and Git.
Once your workspace is ready, you'll dive into the world of kernel programming
by creating your first kernel module.
This hands-on experience will give you a practical understanding of operating
systems and get you ready for future coding tasks.

:::caution

If you follow the YouTube videos, be mindful that the videos are general and
work without being in this specific course. Especially in Part 2, do not clone
the GitHub repository, instead clone your GitLab repository with the
instructions [here](setup#clone-your-code-repository).

:::

There's two scripted YouTube videos I created that roughly correspond to Parts
1 and 2 for Windows.
- Part 1: https://youtu.be/opo53MSqETk
- Part 2: https://youtu.be/COR3wE-hL2s 

## Part 1: Creating Your Virtual Machine

In this first part of the lab, we'll embark on a journey where we lay the
groundwork for creating and configuring your very own virtual machine (VM).
You will be installing an operating system from scratch, and you'll get 
the opportunity to understand the internals and functions of an OS first-hand.
This hands-on approach will help cement your understanding of operating system
concepts, as you'll witness the installation and booting process, set up system
configurations, and interact directly with the OS, all within the safe, isolated
environment of a VM.

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


:::caution

Do not try to open the `.iso` file! You just need to have it downloaded and
accessible for the VM software.

:::

### Setup Virtual Machine

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">

:::note

If you have Windows Home edition, you need to do an additional step before you
start. Please go to this URL:
https://www.itechtics.com/enable-hyper-v-windows-10-home/?expand_article=1 and
follow the 3 steps under "Install Hyper-V in Windows 10 Home".

You may be able to get Windows Education keys through the school at this URL:
https://portal.azure.com/?Microsoft_Azure_Education_correlationId=512f7ee6-bbbb-45ab-873c-f4a8e4992360#view/Microsoft_Azure_Education/EducationMenuBlade/~/software.

:::

We're going to use **Hyper-V** to host our virtual machine.
You can more about it [here][hyper-v], but it's built into Windows.
Press the Windows key and type "Turn Windows features on or off" and hit enter.
In the *Turn Windows features on or off* window, select *Hyper-V* and make sure
both *Hyper-V Management Tools* and *Hyper-V Platform* are checked.
Press *OK* and restart your computer if needed.

After installing Hyper-V press the Windows key again, type "Hyper-V Quick
Create", and press enter.
Allow this app to make changes to your device and wait for it to load.
Now we'll create your virtual machine by following these steps:

1. Click on the *_Local installation source* near the bottom of the left side.
2. In the main part of the window click *Change installation source...*
   and select the Debian Testing ISO you downloaded. 
   The ISO should have a filename similar to `debian-testing-amd64-netinst.iso`.
3. Uncheck *This virtual machine will run Windows*.
4. Click *More options* near the bottom right and fill out *Name* with "Debian
   Testing", or whatever you'd like to name your virtual machine.
5. After it's done setting up, click *Connect*.
   This should open a new window, in this window click *Start*.


  </TabItem>
  <TabItem value="mac" label="macOS">

We're going to use [UTM][utm] to host our virtual machine.
You do not need to pay for it, although if you want to support the developers
and get automatic updates you can get it on the [App Store][utm-app-store].
If you'd like the free version, please download it [here][utm-app].

Launch **UTM** and create your virtual machine by following these steps:
1. Click *Create a New Virtual Machine*.
2. Click *Virtualize*.
3. Click *Linux*.
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

We're going to use [virt-manager][virt-manager] to host our virtual machines.
These instructions are specific for a Debian based Linux distribution, so
you may need to adjust for your package manager. 

Install **virt-manager** using `sudo apt install virt-manager`.
You should be able to launch `virt-manager` and follow these steps:
1. Click *File* then *New Virtual Machine*.
2. Select *Local install media (ISO image or CDROM)*.
3. Click *Forward*.
4. Under *Choose ISO or CDROM install media*, click *Browse* and select the
   Debian Testing ISO you downloaded. The ISO should have a filename similar to
   `debian-testing-?????-netinst.iso`. Finally, click *Forward*.
5. You can use the defaults for Memory and CPU settings for now, click
   *Forward*.
6. You can leave the defaults for this section, but increase the disk image size
   to 40.0 GiB, and click *Forward*.
7. Keep the default name, or use `debian-testing`. Select *Customize
   configuration before install*, and click *Finish*.
8. In the overview configuration go down to *Firmware:* and select UEFI x86_64
   then click *Begin Installation* in the top left.


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

Hyper-V automatically removes the installation media, so there's nothing to
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

virt-manager should automatically remove the installation media, so there's
nothing to do for this step.

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
sudo apt install bear build-essential clang clangd gdb git meson python3 strace valgrind zsh
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
git remote add upstream git@laforge.eecg.utoronto.ca:ece344/2023-fall/student/ece344
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

:::note

If you're on Windows**, use `<USERNAME>@<HOSTNAME>` instead where
`<HOSTNAME>` is what you picked in step 6 of *Install Debian Testing*.
This is because Windows will change the IP address of your VM after ever
reboot.
VSCode will also ask you what the machine is, pick "Linux".
You may also find that if you reboot on Windows, your VM won't be able to
access the internet.
In this case type `sudo reboot` in your VM's terminal, close VSCode, and
reconnect.

:::


Click open on the splash screen or find it in the menu.
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

### Additional Configuration

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

Now we're going to change our default compiler to Clang from GCC.
In general Clang gives better error messages than GCC, and it's much easier to
extend (you may write code for it if you're interested in compilers).
You'll find additional tools and helpful utilities with Clang, some of which
we'll use in this course.
Change the default compiler using the following command:

```
sudo update-alternatives --set cc /usr/bin/clang
```

Next, we'll change our shell to something a bit better than Bash.
We're going to use Zsh, which is the default shell now on macOS.
In addition, we're going to use [Oh My Zsh][oh-my-zsh] to make our shell
a bit more usable.
Install this custom Zsh configuration by running the following command:

```
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

If it asks for your `sudo` password, remember that it's your **user password**.
This will change your shell over to the new one.
You may now edit the configuration file for your shell using `nano -w ~/.zshrc`.
I suggest changing the line that says `ZSH_THEME="robbyrussell"` to
`ZSH_THEME="lukerandall"`.
If you don't want to type your **SSH passphrase** all the time, also change
the line that says `plugins=(git)` to `plugins=(git ssh-agent)`.
Now, close your VSCode window and re-open it, pick *ece344* with the SSH again
to re-connect.
Now, in the VSCode terminal, type `ssh-add` and it'll ask you for your
passphrase, enter it and you should see an `Identity added` message.
Now you don't have to re-enter your passphrase again, convenient.

Congratulations, that was quite a journey!
You used virtualization to install your own Linux operating system from scratch.
This is a rite of passage for any operating system course, and will serve you
well in your career.
Virtualization is very useful for software development, the first thing you'll
notice is that you're using the same operating system as the rest of your
friends and everything is consistent between you (no matter your actual
operating system).

## Part 3: Your First Kernel Module

You're going to write (or at least use) your first kernel module.
Kernel code is much different from user code (which is any code you can
run as a program).
For this lab you're going to explore some kernel code, and make a minor
one line change to make sure you can submit labs using Git.

### Development

From your development environment, type the following command:

```
cd hello-kernel
```

We'll be using this directory for the lab, on the left sidebar you should
also expand the *hello-kernel* directory to see 3 files: *.clangd*,
*.gitignore*, *hello.c*, and *Makefile*.
Open *hello.c*, this is the code we're going to compile, you may notice
there's some new things here.
The content of this file should match the following:

```c title="hello.c"
#include <linux/module.h>
#include <linux/printk.h>

int hello_init(void) {
    pr_info("Hello kernel.\n");
    return 0;
}

void hello_exit(void) {
    pr_info("Goodbye kernel.\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_AUTHOR("Your name");
MODULE_LICENSE("GPL");
```

:::note

If you're using `x86_64` you may notice 9 errors, that's expected, so you can
ignore them (it'll still compile). This is because the kernel relies on
features only in `gcc`, and our tool uses `clang`. This will not be an
issue in future labs.

:::

The kernel developers use [Make][make] to compile the kernel, so we have to use
it to make our kernel module too (for future labs we'll use a more modern build
system).
Try running the following command:

```
make
```

You should get an error like
`/lib/modules/6.3.0-1-arm64/build: No such file or directory`.
We're missing the kernel's build files, and its header files.
You likely have never seen an `#include` to a file starting with `linux/`, and
your compiler can't find them either.
Your virtual machine includes standard C header files (such as `stdio.h`), but
most users do not write Linux kernel modules, so we'll have to install the
header files.
Run the following command to install the Linux header files:

```
sudo apt install linux-headers-$(uname -r)
```

Now try running the following command again:

```
make
```

This should complete successfully and create a bunch of new files.
You'll notice that it didn't create an executable, so there's nothing we can
run.
We can't execute the kernel, since it's already running (we're currently using
the operating system), we need to insert our code into the running kernel.
To insert our module into the kernel, run the following command:

```
sudo insmod hello.ko
```

You'll notice nothing happens, but there's no error messages, what's going on?
Did it work?
Let's look at the code briefly, the `module_init()` "function" specifies
what function to execute when the kernel loads the module.
In our case it's `hello_init`.
Our `hello_init` function calls `pr_info` which is also something new.
`printf` does not exist in the kernel, because the standard C library doesn't
exist in the kernel, it has to start from scratch.
`pr_info` acts as `printf` for the kernel, but instead of printing to the
terminal it logs the message internally.
There's several other logging levels (such as errors, warnings, and debug),
but we're using the info level, which is meant to represent non-critical
information.
To see all the kernel information messages type the following command:

```
sudo dmesg -l info
```

You should see `Hello kernel.` at the end of the last line (the number in the
square brackets is the number of sentences since your kernel started).
So, we verified that the kernel executed our code.
To remove the module from the kernel (which runs the function specified
by `module_exit`) run the following command:

```
sudo rmmod hello
```

Now, let's check that our code ran.
Type the following command again:

```
sudo dmesg -l info
```

We should see `Goodbye kernel.` as the last line now.
We can also use some kernel module utility programs, try running:

```
sudo modinfo hello.ko
```

You should be able to see that the string specified by `MODULE_AUTHOR` in the
C file gets displayed here.
Change the string from `"Your Name"` to your actual name.
Make the change and save your *hello.c* file.
Recompile your kernel module by typing `make` again.
Run the following command again:

```
sudo modinfo hello.ko
```

You should see your name again.
This is the only code change you're required to submit for this lab, there's
some additional questions where you'll experiment with the code, but for now
that's it (a one line change).

### Submission

We need to make a commit to save a checkpoint of all our work (even if it's
one line).
Type `git status` in the terminal to see all of your modifications.
You should see `modified:   hello.c` in red.
Red means when you type `git commit` (to save all your changes), this
modification will not be included.
Type `git add hello.c`, then type `git status` again.
You should see the same line, but in green now.
Since these are all our changes, and they're all included, we can make our
commit now.
Type `git commit -m "[Lab 0] Changed MODULE_AUTHOR to <Your name>."`, where you
just like your change, replace `<Your name>` with your actual name.
The string after `-m` is your commit message, it should be descriptive of your
changes, so if you ever need to go back it's much easier to find your changes.
Trust me, future you will thank you for writing good commit messages.
You can also type just `git commit`, and it'll open a text editor where you can
write more.
Good commit messages start with a one line description, then have newlines
separating paragraphs that explain why you needed to make the change.
At any rate, after commit you should get a message confirming you saved all
your changes.
It should end with: `1 file changed, 1 insertion(+), 1 deletion(-)`.

Now all our changes are saved on the virtual machine.
We need to make them available on the GitLab server as well.
First, we'll do another sanity check, type `git lol`.
You should see your latest commit message at the very top, and `(HEAD -> main)`
to the left of your message.
`HEAD -> main` means your repository is on the `main` branch (you don't need
to use multiple branches in this course).
The line below should say `(origin/main, origin/HEAD)`, `origin` is just another
name for the remote GitLab server and `origin/main` is the `main` branch
on the server (we can ignore `origin/HEAD`).
This means the `origin` server does not have the latest commit (changes),
if you ran the `git clone` command again you wouldn't see your changes.
You can also double-check the website that your changes aren't there.
To make your `main` branch match the `main` branch on `origin` (the GitLab
server) type `git push`.
You should see it transfer and some information about what new commits the
server has now.
Type `git lol` again, and you should see `HEAD -> main` and `origin/main` on the
same line.
Triple-check the website, refresh and your changes should be there now.

For future labs we'll only look at the time you push your changes to the GitLab
server.
We will never use your commit times (or file access times) as proof of
submission, only when you push your code to the course Git server.
You may push as many commits as you want (you should save your work often), your
latest commit that modifies the lab files counts as your submission for the lab.

To finish up, you'll answer some questions on Crowdmark (you should've received
an email).
This lab serves as a warm-up to get you familiar with real-world software
development.
Hopefully you learned something new, and it's okay if things didn't work the
first time, that means you definitely learned something.
The course staff and I will always be around to help, I hope you enjoy!

[debian-installer]: https://www.debian.org/devel/debian-installer/
[debian-amd64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso
[debian-arm64-iso]: https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/arm64/iso-cd/debian-testing-arm64-netinst.iso
[utm]: https://getutm.app/
[utm-app-store]: https://apps.apple.com/us/app/utm-virtual-machines/id1538878817
[utm-app]: https://github.com/utmapp/UTM/releases/latest/download/UTM.dmg
[hyper-v]: https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
[virt-manager]: https://virt-manager.org/
[git]: https://git-scm.com/
[git-for-windows]: https://git-scm.com/download/win
[1password]: https://1password.com/
[bitwarden]: https://bitwarden.com/
[gitlab]: https://laforge.eecg.utoronto.ca/
[git-book]: https://git-scm.com/book/en/v2
[vscode]: https://code.visualstudio.com/
[oh-my-zsh]: https://ohmyz.sh/
[make]: https://www.gnu.org/software/make/
