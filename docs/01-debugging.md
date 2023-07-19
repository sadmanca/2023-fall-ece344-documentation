---
sidebar_position: 1
---

# Lab 1: Debugging and Tools

## Setting up debugging
### Install gdb:

***EDIT: gdb should already be installed now***

Now you are good to go for debugging using command line. If you choose this traditional way to debug, checkout [gdb tutorial](https://web.eecs.umich.edu/~sugih/pointers/summary.html) as a starting point. [gdb manual](https://sourceware.org/gdb/current/onlinedocs/gdb.html/) provides every detail you need to know about gdb.

### Setup debugging with gui
With gdb installed, you can use a modern editor or ide to debug visually. This section will use visual studio code as an example. In [lab 0](./00-setup.md), you should have vscode setup either on vm directly or through remote access.

#### Setup debugging in project
1. **EDIT: clangd is installed instead**
2. VSCode, with [Meson extension](https://marketplace.visualstudio.com/items?itemName=mesonbuild.mesonbuild) installed, should recognize the meson project once you open it. If not, open up command palette and run **Meson: Reconfigure**.
3. Create a launch target configuration in `.vscode/launch.json`. Bellow is an example for lab 1.
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
4. Now everything is setup. Click the Debug/Run icon on the upper right side or **Run>Start Debugging** or hit `F5` to test the setup.


## An example
With debugger setup, let's try out an example.

If you try running debugger in previous step, vscode with open up `example.c`, with a warning message that exception has occurred. 

![](/img/debug_exception.png)

The warning message suggests that we are accessing a memory address that we are not allowed to, a.k.a segment fault. It also shows that the offending address is `0x0`. We can check the VARIABLE section on the left panel that `result_2` has a value of `0x0`, and we are dereferencing it.

The solution is simple, check if a pointer is `NULL` before dereferencing it. Hold up before you cheer. Another bug still exists. Let's check the DEBUG CONSOLE, and wee will see that the program prints `1 + 3 = 0`, and my math teacher tells me that's wrong.

This bug is more tricky. We need to step through the program to see what happens. Gdb provides a great tool calls breakpoint. We can click on the left side of the line number in interest, 14 in this case. Gdb will pause before executing this line. Let's start the debugger again.

![](/img/debug_breakpoint.png)

There's a tool bar in the upper middle of the editor. From left to right, they are continue, step over, step into, step out, restart and stop. Continue means resuming execution until the next breakpoint. Step over means executing the current line and stop. Step into means resuming execution and stop right after the calling function starts. If there is no function call, it is same as step over. Step out means resuming execution until the current function finishes.

Let's try clicking step over, and see that after line 14, `result_1` points to 4, the expected result. Step over again and it turns to 0. We can restart and break at line 15 instead. Stepping into the function, VARIABLE changes to display the local variables of the current function. Notice that `c` is 4. On CALL STACK, click `example!main` to view local variables on the main function stack, and `result_1` still points to 4. Stepping over to line 6, we can see that `c` changes to 0, and so does the value `result_1` points to.

Now we can see that the root cause is returning a pointer to a memory address on current function's stack. That memory is no longer valid after function returns. The next function call can easily overwrite the memory.

Let's pause for now and think about why the `add_nonnegative` function returns a pointer instead of an integer. This function adds up two non-negative numbers, and if one of the argument is negative, it needs to report an error. Now the program chooses to report the error by returning a `NULL`. The correct implementation in this case need to allocate an integer on heap and returning its address. This approach works, but has two downsides. First, memory allocation introduce significant performance overhead. Second, the caller of the function now bears the burden to free the memory when it is no longer needed. Thus, returning a pointer to signal an error seems not worthwhile.

When we need to return more than one information, we generally have two options. First, we need to check if we can pack these information into a small piece of data that can be efficiently returned. If we pack all information into a large struct, copying it across function stack wastes time and memory. In our example, it is possible. Because sum of two non-negative numbers cannot be negative, we can return a negative number to represents an error. If compacting information is not possible, we are left with another option. The function can "return" most of the information in argument. More precisely, function can accept pointers as "output argument", and the function will write to the value pointed by these pointer. This pattern is widely used in C programming to work around the language limit.

## Start coding and debugging
Now with some debugging experience, let's write some code. In `src` directory in starter code, `linklist.c` and `parse.c` is provided. Please implement these two files per instruction in the files and in `include/parse.h`. `tests` folder contains some basic check. Use `meson test -C builddir` to run the test. You can add debugger support for tests by adding new entries in `launch.json`. Happy coding.
