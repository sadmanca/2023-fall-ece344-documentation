---
sidebar_position: 1
---

# Lab 1: Debugging and Tools

## Setting up debugging
### Install gdb:
```
sudo apt-get install gdb
```
Now you are good to go for debugging using command line. If you choose this traditional way to debug, checkout [gdb tutorial](https://web.eecs.umich.edu/~sugih/pointers/summary.html) as a starting point. [gdb manual](https://sourceware.org/gdb/current/onlinedocs/gdb.html/) provides every detail you need to know about gdb.

### Setup debugging with gui
With gdb installed, you can use a modern editor or ide to debug visually. This section will use visual studio code as an example.

There are two ways to use vscode to debug on a virtual machine: install vscode on virtual machine, or use vscode installed on host machine and setup a remote connection to virtual machine.

#### Install vscode on vm (option 1)
1. Download vscode from https://code.visualstudio.com/Download. Choose the `.deb` version, and select `x64` if your vm is in `amd64` or `arm64` if your vm is in `arm64` (typically for vm on apple silicon). If you are not sure which architecture you are using, run `uname -a` on the command line. Double click the downloaded `.deb` file and the install process starts.
2. Install [C/C++ extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) and [Meson extension](https://marketplace.visualstudio.com/items?itemName=mesonbuild.mesonbuild).

#### Install vscode on your host machine and setup remote connection (option 2)
1. Download vscode from https://code.visualstudio.com/Download and install it on your host machine.
2. Install [Remote-SSH extention](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh). Installing [Remote Development extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) is recommended.
3. From Cammand Palette (Ctrl/Cmd+Shift+P) select **Remote-SSH: Connect to Host...** and enter the `user@hostname`.
4. If password is setup for ssh on vm, enter your password.
5. If vscode cannot detect the platform of vm, select Linux.
6. Install [C/C++ extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) and [Meson extension](https://marketplace.visualstudio.com/items?itemName=mesonbuild.mesonbuild) on remote machine (vm).

#### Setup debugging in project
1. VSCode, with [Meson extension](https://marketplace.visualstudio.com/items?itemName=mesonbuild.mesonbuild) installed, should recognize the meson project once you open it. If not, open up command palette and run **Meson: Reconfigure**.
2. Create a launch target configuration in `launch.json` in `.vscode` folder. Bellow is an example for lab 1.
```
{
    "configurations": [
        {
            "name": "example",
            "request": "launch",
            "type": "cppdbg",
            "MIMode": "gdb",
            "envFile": "${workspaceFolder}/${config:mesonbuild.buildFolder}/meson-vscode.env",
            "cwd": "${workspaceFolder}/${config:mesonbuild.buildFolder}",
            "program": "${workspaceFolder}/${config:mesonbuild.buildFolder}/example",
            "stopAtEntry": false,
            "preLaunchTask": "Meson: Build example:executable"
        }
    ]
}
```
3. Now everything is setup. Click the Debug/Run icon on the upper right side or **Run>Start Debugging** to test the setup.


## An example


