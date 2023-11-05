---
sidebar_position: 1
---

# Lab 1: Process Viewer

**Due: September 20 @ 11:59 PM**

In this lab you'll create a small utility called *Toronto ProcesseS*
(`tps`) that prints out the currently running processes on the machine.
Your implementation uses the same mechanisms as utilities like `ps` and
`top` (you may want to use these to test your program).
This is the Linux version of Windows *Task Manager* and macOS
*Activity Monitor*.
You'll be using Git to submit your work and save your progress.

## Setup

Ensure you're in the `ece344` directory within VSCode.
Make sure you have the latest skeleton code from us by running:
`git pull upstream main`.

This will create a merge, which you should be able to do cleanly.
If you don't know how to do this read [Pro Git][pro-git].
**Be sure to read chapter 3.1 and 3.2 fully.**
This is how software developers coordinate and work together in large projects.
For this course, you should always merge to maintain proper history between
yourself and the provided repository.
**You should never rebase in this course, and in general you should
never rebase unless you have a good reason to.**
It will be important to keep your code up-to-date during this lab as the
test cases may change with your help.

You can finally run: `cd tps` to begin the lab.

## Task

You should output the PID and name of every running process on your machine
(or dev container if you're using the recommended setup).
Your output should be exactly the same as if you ran
`ps -eo pid:5,ucmd` (except for the PID and name of your process).
You should start by printing a header, which will be `PID`
right-justified with a width of 5 characters, a space, then `CMD`.
To do this, your implementation needs to read the `/proc` directory
and its contents.
By default, the directories should be in the order of ascending pid.
Any directory within `/proc` that's a number (e.g. `1`)
represents a process with that pid.
After that you should read the `/proc/<pid>/status` file to get it's
name.
The file starts with `Name:` followed by a tab character, then
the name (anything that isn't a newline character), and finally followed by
a newline character (not part of the name).
For each process you should output the pid, right-justified with a width of
5 characters, a space, then the name.

You need to check for errors, and properly close all directories and file
descriptors.
You should only need two file descriptors open at any given time.
If you fail to open a `status` file, that means the process no longer exists.
You should handle this case by not printing any information about this
now nonexistent process.

## Building

First, make sure you're in the `tps` directory if you're not already.
After, run the following commands:

    meson setup build
    meson compile -C build

Whenever you make changes, you can run the compile command again.
You should only need to run setup once.

## Testing

After building, you can run your program with `build/tps` and compare
your output to running `ps -eo pid:5,ucmd`.
You may also choose to run the test suite provided with the command:

    meson test --print-errorlogs -C build

If you fail a test, you should be able to read the log file given at the end
of the output for a reason why the test failed.

If you would like to run a test directly, run:

    tests/ps_compare.py build/tps

After building your program. You should be able to see other tests in the
`tests` directory.

## Grading

Run the `./grade.py` script in the directory.
This will rebuild your program, run the tests, and give you a grade out of
100 based on your test results.
Note that these test cases may not be complete, more may be added before the
due date, or there may be hidden test cases.
These labs are new, so we may need to change.

## Tips

You'll want to read the documentation on some C functions (some are light
syscall wrappers).
Some header files you'll need to use are provided for you in the skeleton code.
You'll need to use the following functions:

    opendir readdir closedir open read close perror exit

You should use all the functions above.
You may be able to complete the lab without them, but this lab is short, and
you'll be using these again for future labs.
It's best to get some experience with them now for the shortest lab.

### Use AddressSanitizer

Re-create the build directory using:

    rm -rf build
    meson setup build -Db_sanitize=address
    meson compile -C build

Then run the test cases manually to see any memory errors.

## Submission

Simply push your code using `git push origin main` (or simply
`git push`) to submit it.
*You need to create your own commits to push, you can use as many
as you'd like.*
You'll need to use the `git add` and `git commit` commands.
You may push as many commits as you want, your latest commit that modifies
the lab files counts as your submission.
For submission time we will *only* look at the timestamp on our server.
We will never use your commit times (or file access times) as proof of
submission, only when you push your code to the course Git server.

## Common Issues

### Tests Randomly Fail when comparing `kworker` processes

There's a workaround for this, please make sure you have the latest code
by running `git pull upstream main`.

### Tests Randomly Fail Otherwise

In very rare cases, a process may exist only when the test executes `ps` and
not exist when the test executes your code (or vice versa). Unfortunately you're
running an entire operating system which is unpredictable. This is expected
and okay. The test environment we use is predictable.

Specifically this comes from: https://github.com/microsoft/vscode/blob/fa99dace5ee3b35a070ca4970422621af07c2781/src/vs/base/node/cpuUsage.sh#L37

[pro-git]: https://git-scm.com/book/en/v2/
