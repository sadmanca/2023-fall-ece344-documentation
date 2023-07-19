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
3. From Cammand Palette (`Ctrl/Cmd+Shift+P`) select **Remote-SSH: Connect to Host...** and enter the `user@hostname`.
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
3. Now everything is setup. Click the Debug/Run icon on the upper right side or **Run>Start Debugging** or hit `F5` to test the setup.


## An example
With the debugging setup, let's try out an example.

If you try running debugger in previous step, vscode with open up `example.c`, with a warning message that exception has occurred. 

![](/img/debug_exception.png)

The warning messages suggest that we are accessing a memory address that we are not allow to, a.k.a segment fault. It shows that the offending address is `0x0`. We can check the VARIABLE section on the left panel that `result_2` has a value of `0x0`, and we are dereferncing it.

The solution is simple, check if pointer is `NULL` before dereferning it. Hold up before you cheer. Another bug still exists. Let's check the DEBUG CONSOLE, and wee will see that the program prints `1 + 3 = 0`, and my math teacher tells me that's wrong.

This bug is more tricky. We need to step through the program to see what happens. Gdb provides a great tool calls breakpoint. We can click on the left side of the line number of the line in interest, 14 in this case. Gdb will pause before executing this line. Let's start the debugger again.

![](/img/debug_breakpoint.png)

There's a tool bar in the upper middle of the editor. From left to right, they are continue, step over, step into, step out, restart and stop. Continue means resume execution until the next breakpoint. Step over mean execute the current line. Step into means resume execution and stop when the calling function starts. If there is no function call, it is same as step over. Step out means resume execution until the current function ends.

Let's try step over, and see that after line 14, `result_1` points to 4, the expected result.Step over again and it turns to 0. We can restart and break at line 15. Step into the function, VARIABLE changes to display the local variables of the current function. Notice that `c` is 4. On CALL STACK, click `example!main` to view local variables on the main function stack, and `result_1` still points to 4. Step over to line 6, we can see that `c` changes to 0, and so does the valud `result_1` points to.

Now we can see that the root cause is returning a pointer to a memory address on current function's stack. That memory is no longer valid after function returns. The next function call can easily overwrite the memory.

Let's pause for now and think about why the `add_nonnegative` function returns a pointer. This function adds up two non-negative numbers, and if one of the argument is negative, it needs to report an error. Now the program choose to report the error by returning a `NULL`. The correct implementation in this case need to allocate an integer on heap and returning its address. This approach works, but has two downsides. First, memory allocation introduce significant performance overhead. Second, the caller of the function now bears the responsibility to free the memory when it is no longer needed. Thus, return a pointer to signal an error seems not worthwhile.

When we need to return more than one information, we generally have two options. First, we need to see if we can pack these information into a small piece of data that can be efficiently returns. If we pack all information into a large struct, copying it across function stack wastes time and memory. In our example, it is possible. Because sum of two non-negative numbers cannot be negative, we can return a negative number to represents an error. If compacting information is not possible, we are left with another option. The function can "return" most of the information in argument. More precisely, function can accept pointers as "output argument", and the funtion will write to the value pointeed by these pointer. This pattern is widely used in C programming to work around the language limit.

## Start coding and debugging
Now with some debugging experience, let's write some code. In `src` directory in starter code, `linklist.c` and `parse.c` is provided. Please implement these two files per instruction in the files and in `include/parse.h`. `tests` folder contains some basic check. Use `meson test -C builddir` to run the test. You can add debugger support for tests by adding new entries in `launch.json`. Happy coding.
