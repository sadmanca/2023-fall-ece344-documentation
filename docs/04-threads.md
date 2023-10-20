---
sidebar_position: 4
---

# Lab 4: Threads

**Due: November 5 @ 11:59 PM**

In this lab you'll create a small library called *Wacky User Threads*
(`wut`) that implements user-space threads.
Your implementation should use the concepts learned during the lectures, along
with some new system calls.
You'll create library called `libwut` this lab, not an executable.
You'll be using Git to submit your work and save your progress.

This lab has an early testing component to make sure you start early and
understand what output you should expect.
It is worth 5% of the lab and is
due **October 25 @ 11:59 PM**.

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

You can finally run: `cd wut` to begin the lab.

## Task

You're going to create a threading library similar to `pthread` in
some respects.
Unlike `pthread`, you will be creating user-level cooperative threads.
This means a thread will continue to execute until it exits, or yields.
You must run your threads in FIFO order (re-queuing them if they yield).
You may use all functions in `ucontext.h` to do the heavy lifting of
initializing and swapping threads in your context switching. We have a demo
of `ucontext` in Lecture 18.
Your version is going to be a C library with the following API:

    void wut_init(void);
    int wut_create(void (*run)(void));
    int wut_id(void);
    int wut_yield(void);
    int wut_cancel(int id);
    int wut_join(int id);
    void wut_exit(int status);

The description of what each function should do is below:


### `void wut_init(void)`

This will always be called once before a user makes any other call to your
library.
You need to set up the main thread executing `wut_init` as thread 0.
You should initialize or setup anything else you need here.

Your library should keep track of the following: the currently running thread,
a FIFO queue of waiting (or ready) threads, and thread control blocks for all
threads. Your thread control blocks should be in a dynamically sized array,
you'll find `reallocarray` helpful.

### `int wut_id(void)`

You should return the `id` of the currently executing thread.



### `int wut_create(void (*run)(void))`

You will create a new thread in this function, that new thread should be
setup to start executing the function given by the `run` argument.
Unlike `pthread`, the `run` function takes no arguments, and does not return
anything.
You should return a unique `wut_id` that your library will use to refer
to this created process.
The IDs should be sequential, start with `0`, and should always
use the lowest ID available.

You should allocate a stack for the new thread, set its user context using
`ucontext_t` (using `makecontext`).
Each thread should have its own thread control block (`tcb`) that you design.
We've provided you a `new_stack()` function that returns a pointer
to a new stack of size `SIGSTKSZ`.
You **must use** this function, mostly for you own sanity, it registers
the stack with `valgrind`, so you don't get a lot of false positives.
If you ever need to use a stack size, use `SIGSTKSZ`.

After initializing the thread control block, you should add it to a ready queue
in FIFO order. You should not switch to this thread yet.

### `int wut_yield(void)`

This function should yield to the next thread on the ready queue. The thread
that called yield should be put at the end of the ready FIFO queue.

This function should return `0` to the caller if it successfully yielded.
Otherwise, it should return `-1` to indicate an error.
Some errors include: no available threads to switch to.

### `int wut_cancel(int id)`

This function should cancel a thread specified by `id` and remove it
from the ready queue, so it will not execute again.
You should also free any memory associated with its stack and `ucontext`.
The cancelled thread's status should be set to `128`, and you should
maintain the information in the thread control block.

This function should return `0` to the caller if it successfully
cancelled.
Otherwise, it should return `-1` to indicate an error.
Some errors include: invalid thread to cancel, cannot cancel self.

### `int wut_join(int id)`

This function should cause the calling thread to block until the thread
specified by `id` terminates (either by exiting to getting cancelled).
Blocking means the current thread should stop running, and not be put into
the ready queue (it cannot execute yet).
Once the thread specified by `id` terminates, the calling thread should be
re-added to the end of the ready queue.
The calling thread should free any memory associated with the thread specified
by `id` including its stack and `ucontext`.
A thread may only be waited on by one other thread.
You should detect and report an error if two threads attempt to join on the
same thread (only the first thread that calls join should succeed).

This function should return the status of the waited on thread to the caller.
Also, the waited on thread should have its thread control block removed and its
`id` should be available to new threads.
Otherwise, it should return `-1` to indicate an error.
Some errors include: invalid thread to wait on, cannot wait on self.

You should only successfully block the calling thread if the thread specified
by `id` is in the waiting (or ready) queue.
You should not successfully join a thread that is waiting on another thread
already.
In this case, return `-1` and continue execution.

If the thread specified by `id` is already terminated, then the thread
calling `wut_join` must continue execution and not be re-added to
the back of the ready queue.
You must of course return the `status` of the terminated thread and clean
up all its resources.

### `void wut_exit(int status)`

This causes the current thread to exit and set its status in the thread
control block to the value given by `status`.
Similar to cancel, this thread should be removed from the ready queue, so it
will not execute again.
You would not want to free the stack at this point (why?).

If this is the final thread in the process, the process should exit with
and exit code of `0`.

Internally the status should only be values between `0` and `255`
inclusive.
You must only store the lower byte of the `status` argument.
If you are unfamiliar with lower level operations in C, you can use:
`status \&= 0xFF;` and afterwards `status` will be between `0` and `255`.
(Note: this is what occurs when you `exit` from a process as well).
This means that successful calls to `wut_join` will also return a
value between `0` and `255`.

## Errors

You need to check for and properly handle errors.
For fatal errors, you should exit with the `errno` of the first fatal
error.
However, your implementation should not generate errors

## Progression

There are 13 tests that you should be able to pass in order, as follows:

1. `main-thread-is-0`
2. `first-thread-is-1`
3. `main-thread-yields`
4. `first-thread-exits-explicitly`
5. `first-thread-exits-implicitly`
6. `first-thread-runs`
7. `main-thread-joins`
8. `first-thread-cancelled`
9. `thread-in-thread`
10. `two-threads`
11. `reuse-thread-0`
12. `error-thread-join-self`
13. `error-thread-yield-none`

To pass the first test (`main-thread-is-0`) you only need to write a partial
implementation of `wut_init` and `wut_id`. Let's look at the source code
for this test, it's located a `wut/tests/main-thread-is-0.c`.

```c
/* Header file for the testing infrastructure, it creates an array of 10240
   integers in shared memory. The purpose of this is to check that your
   program sets the correct values, even if it crashes. The tests run the
   `test` function in a new child process, and after that process terminates
   the test runs the `check` function. */
#include "test.h"

/* This is the header file with all the functions you're creating for your
   threading library. */
#include "wut.h"

/* This `test` function should run the code for the test itself. The test should
   only write to an element in `shared_memory` once (only the last write gets
   checked). You can either write the return values of library calls, or an
   `int` variable you have your threads change. This example just calls
   `wut_init` to initialize your library, all tests should begin with this
   and only call it once. After initialize, it calls `wut_id` and writes the
   result to array index 0 in shared memory. */
void test(void) {
    wut_init();
    shared_memory[0] = wut_id();
}

/* The `check` function runs after the child process that executes `test` exits.
   Here we just call `expect` with the `shared_memory` element we want to check,
   then the value we expect, then a message to print if they do not match. For
   this test we just expect the return value of `wut_id` is 0 if we do not
   create any other threads. After calling `wut_init` the id of the main thread
   should be 0. */
void check(void) {
    expect(
        shared_memory[0], 0, "wut_id of the main thread is wrong"
    );
}
```

After this you should be able to read the rest of the tests in the `tests`
directory and make sure you understand the expected values. There is a special
expected value that indicates the `shared_memory` element never changed, and
that's `TEST_MAGIC`.

Let's look at a test submitted by a student in the previous offering of the
course. In the comments I use numbers in parentheses to indicate the order of
execution, for example: `/* (1) First step */`, then `/* (2) Second step */`.
Please find the code below:

```c
#include "test.h"

#include "wut.h"

int x = 0; 

void null_run(void) {
    /* (12) Thread 0 starts executing and immediately returns, causing it to
            implicitly exit. The only other thread to run is thread 1, which
            now returns from its join. */
    return;
}

void t1_run(void) {
    /* (4) Thread 1 cancels thread 0, thread 0 is now terminated and no thread
           is attempting to join thread anymore. */
    shared_memory[4] = wut_cancel(0);
    /* (5) Thread 1 joins thread 0, which is terminated, so join returns
           immediately and thread 1 continues to execute. The status of
           thread 0 should be 128 because it got cancelled. */
    shared_memory[5] = wut_join(0);
    /* (6) Thread 1 joins thread 2, which is in the ready queue. Thread 1 blocks
           and thread 2 starts executing `t2_run`. */
    /* (13) Thread 1 continues execution and writes the return value of
            `wut_join` to index 6 of shared memory, it should get a status of
            0 because thread 2 terminated normally. */
    shared_memory[6] = wut_join(2);
    /* (14) Thread 1 increments the global variable `x` from 1 to 2. */
    ++x; 
    /* (15) Write the value of `x` to index 8 of shared memory, it should be 2.
    */
    shared_memory[8] = x;
    /* (16) Thread 1 implicitly exits, we have no other threads and the process
            terminates. The join at time (3) never returns, since the original
            main thread got cancelled, and when we check `shared_memory` at
            index 3, we use the special value to indicate that the write to
            shared memory never happened. */
}

void t2_run(void) {
    /* (7) Thread 2 starts executing, we have no other threads in the ready
           queue. It increments the global variable `x` from 0 to 1. */
    ++x;
    /* (8) Write the value of `x` to index 7 of shared memory, it should be 1.
    */
    shared_memory[7] = x;
    /* (9) Create a new thread, the lowest available thread id should be 0 since
           it got joined at (5). The current running thread is still 2, and the
           ready queue should be = [0]. */
    int id4 = wut_create(null_run); // queue = {2, 0}
    /* (10) Write the return value of `wut_create` to index 9 of shared memory,
            it should be 0. */
    shared_memory[9] = id4;
    /* (11) Thread 2 should implicitly exit, this should cause thread 1 to
            unblock and get added to the ready queue. The queue should now be:
            [0, 1]. Since thread 2 exited, we should run thread 0 next and our
            ready queue is [1]. */
}

void test(void) {
    wut_init();
    /* (1) We only have the main (initial) thread running */
    shared_memory[0] = wut_id();
    shared_memory[1] = wut_create(t1_run);
    shared_memory[2] = wut_create(t2_run);
    /* (2) Thread 0 is running, and the ready queue should be = [1, 2] */
    int id2 = shared_memory[2];
    /* (3) Thread 0 joins thread 2. Thread 0 blocks. Thread 1 starts running
           `t1_run`, and our ready queue is = [2] */
    shared_memory[3] = wut_join(id2);
}

void check(void) {
    expect(
        shared_memory[0], 0, "wut_id of the main thread is wrong"
    );
    expect(
        shared_memory[1], 1, "wut_id of the second thread is wrong"
    );
    expect(
        shared_memory[2], 2, "wut_id of the third thread is wrong"
    );
    expect(
        shared_memory[3], TEST_MAGIC, "wut_join should never return because"
                                      " id 0 is cancelled"
    );
    expect(
        shared_memory[4], 0, "second wut_join should return 0"
    );
    expect(
        shared_memory[5], 128, "third wut_join should return the status of"
                               " cancelled thread"
    );
    expect(
        shared_memory[6], 0, "fourth wut_join should should return 0"
    );
    expect(
        shared_memory[7], 1, "x should increment by 1"
    );
    expect(
        shared_memory[8], 2, "x should increment again"
    );
    expect(
        shared_memory[9], 0, "new thread should reuse id 0"
    );
}
```


## Early Testing (5%)

The test cases assume you have a more-or-less complete working implementation.
In order for you to test your code in development, and to suggest changes
you may modify the code in `test/main.c` to call and test your library.
When you build your code the executable will be `build/test/wut`.

You should not modify `check` and code should call `check`
*one or more times*.
The purpose of `check` is to check the value of an integer that you'd
like to know from the solution.
You'll be provided the output of the `check` calls shortly after the
due date.

You may create however many threads you wish, and do whatever calls you wish.
However, your program must terminate, and cannot have an infinite loop.
These checks may be turned into test cases and used as part of the suite.

You can look at the existing tests, but this `check` function is different
from the `test` and `check` functions in the testing framework. Please do not
create a `test` function, your execution starts from `main`.

## Building

First, make sure you're in the `wut` directory if you're not already.
After, run the following commands:

    meson setup build
    meson compile -C build

Whenever you make changes, you can run the compile command again.
You should only need to run setup once.

## Testing

You cannot execute your library directly, however you can run the test programs
manually.
Please find the files in `tests/*.c`.
You should be able to read and understand what they're doing with your library.
You'll find the executables in `build/tests/*`.

You may also choose to run the test suite provided with the command:

    meson test --print-errorlogs -C build

The first 10 tests are arranged in the order you should do them.

## Grading

Run the `./grade.py` script in the directory.
This will rebuild your program, run the tests, and give you a grade out of
100 based on your test results.
Note that these test cases may not be complete, more may be added before the
due date, or there may be hidden test cases.
These labs are new, so we may need to change.

## Tips

You'll want to read the documentation on the `ucontext` family of C functions.
Some header files you'll need to use are provided for you in the skeleton code.
You may include additional parts of the standard library.
It's highly recommended to at least use the following functions:

    getcontext
    makecontext
    swapcontext
    exit

You may also find `sys/queue.h` helpful, especially the `TAILQ`
family of functions that implement a useful linked list.
There's some other headers and functions you may find useful during development
provided for you.

## Submission

Simply push your code using `git push origin main` (or simply
`git push`) to submit it.
*You need to create your own commits to push, you can use as many
as you'd like.*
You'll need to use the `git add` and `git commit` commands.
Push as many commits as you want, your latest commit that modifies
the lab files counts as your submission.
For submission time we will *only* look at the timestamp on our server.
We will never use your commit times (or file access times) as proof of
submission, only when you push your code to the course Git server.

[pro-git]: https://git-scm.com/book/en/v2/
