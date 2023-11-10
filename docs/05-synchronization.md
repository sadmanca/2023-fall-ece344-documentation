---
sidebar_position: 4
---

# Lab 5: Synchronization

**Due: November 22 @ 11:59 PM**

**This lab also requires you to answer questions on Crowdmark.**

In this lab you'll be making a hash table implementation safe to use
concurrently.
You'll be given a serial hash table implementation, and two additional hash
table implementations to modify.
You're expected to implement two locking strategies and compare them with the
base implementation.
The hash table implementation uses separate chaining to resolve collisions.
Each cell of the hash table is a singly linked list of key/value pairs.
You are not to change the algorithm, only add mutex locks.
Note that this is basically the implementation of Java concurrent hash tables,
except they have an optimization that doesn't create a linked list if there's
only one entry at a hash location.

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

You can finally run: `cd pht` to begin the lab.

## Task

In order to make a hash table work concurrently, you need to first understand
how it works serially. Read and understand the initial base implementation.
Afterwards you'll create version 1 (v1) of the hash table that's thread-safe.
For this version you're only allowed to use a single mutex.
Finally, you'll create version 2 (v2) of the hash table that's also thread-safe
and performant with as many mutexes as you'd like.

### Understand the Serial Hash Table Implementation

The initial base implementation is heavily commented, based on using linked
lists previously, you should have an understanding of what the `SLIST` functions
do. First read `src/hash-table-common.h`, this defines the capacity of the
hash table (which does not change, unlike real hash tables), and the hashing
function. Next, read `src/hash-table-base.h` to see the declarations of all the
functions in the base (serial) hash table. Finally, read `src/hash-table-base.c`
for the implementation details.

### Creating Hash Table v1

Using only `pthread_mutex_*` you should create a thread-safe version of
`hash_table_v1_add_entry`.
All other functions are called serially, mainly for sanity checks.
By default, there is a data race finding and adding entries to the list.

For the first version, `v1`, you should only be concerned with
correctness.
Create a **single** mutex, only for `v1`, and make 
`hash_table_v1_add_entry` thread-safe by adding the proper locking
calls.
You should not create any global variables, and instead add any data you'd
like to the `struct`s (`hash_table_vX`, `hash_table_entry` and/or `list_entry`).
You need to initialize the mutex in `hash_table_v1_create` and destroy
it in `hash_table_v1_destroy`.

Your code changes
should not modify `contains` or `get_value`. Any other code
modifications are okay. However, you should not change any functionality of the
hash tables.
Only modify code in `hash-table-v1.c` for this version of the hash
table.
After completing this version, answer questions 1 and 2 on Crowdmark.


### Creating Hash Table v2

For the second version, `v2`, you should be concerned with correctness
and performance.
You can now create as many mutexes as you like in `hash-table-v2.c`.
Make `hash_table_v2_add_entry` thread-safe by adding the proper
locking calls.
You should not create any global variables, and instead add any data you'd
like to the `struct`s (`hash_table_entry` and/or `list_entry`).
You need to initialize the mutex in `hash_table_v2_create` and destroy
it in `hash_table_v2_destroy`.

Your code changes
should not modify `contains` or `get_value`. Any other code
modifications are okay. However, you should not change any functionality of the
hash tables.
Only modify code in `hash-table-v2.c` for this version of the hash
table.
After completing this version, answer questions 3 and 4 on Crowdmark.

## Additional APIs

Similar to the suggestion in Lab 4, the base implementation uses a linked list,
but instead of `TAILQ`, it uses `SLIST`.
You should note that the `SLIST_` functions modify the `pointers`
field of `struct list_entry`.
For your implementation you should only use `pthread_mutex_t`, and
the associated init/lock/unlock/destroy functions.
You will have to add the proper `#include` yourself.

## Building

First, make sure you're in the `pht` directory if you're not already.
After, run the following commands:

    meson setup build
    meson compile -C build

Whenever you make changes, you can run the compile command again.
You should only need to run setup once.

## Starting

After you build you'll have a `build/pht-tester` executable.
The executable takes two command link arguments: `-t` changes the number
of threads to use (default 4), and `-s` changes the number of hash table
entries to add per thread (default 25,000).
For example, you can run: `build/pht-tester -t 8 -s 50000`.

### Tester

The tester code generates consistent entries in serial such that every run
with the same `-t` and `-s` flags will receive the same data.
All hash tables have room for `4096` entries, so for any sufficiently
large number of additions, there will be collisions.
The tester code runs the base hash table in serial for timing comparisons,
and the other two versions with the specified number of threads.
For each version it reports the number of µs per implementation.
It then runs a sanity check, in serial, that each hash table contains all
the elements it put in.
By default, your hash tables should run `-t` times faster (assuming you
have that number of cores).
However, you should have missing entries (we made it fail faster!).
Correct implementations should **at least** have no entries missing in
the hash table.
However, just because you have no entries missing, you still may have issues
with your implementation (concurrent programming is significantly harder).

### Example Output

You should be able to run `build/pht-tester -t 8 -s 50000` and get the following
output:

    Generation: 130,340 usec
    Hash table base: 1,581,974 usec
      - 0 missing
    Hash table v1: 359,149 usec
      - 28 missing
    Hash table v2: 396,051 usec
      - 24 missing

## Errors

You will need to check for errors for any `pthread_mutex_*` functions
you use.
You may simply `exit` with the proper error code.
You are expected to destroy any locks you create.
The given code passes `valgrind` with no memory leaks, you should not
create any.

## Tips

Since this is a lab about concurrency and parallelism, you may want to
significantly increase the number of cores given to your virtual machine, or
run your code on a Linux machine with more cores.

## Grading

There is no `grade.py` for this lab, because it's mainly graded manually.
We run your program on a multi-core machine, and as long as your performance
is reasonable (v1 is likely slower than the base, and v2 is likely much faster).
You'll receive 18% for each version. You'll also receive 4% if Valgrind does
not report any memory leaks. The remaining 60% of the grade is based on your
written responses on Crowdmark.

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

## Common Issues

### My Performance Isn't What Expected

You likely have a data race. You can look at the online tool, or run
ThreadSanitizer yourself with the following commands:

    meson setup -Db_sanitize=thread --wipe build
    meson compile -C build
  
Then run the tester. If you want to disable ThreadSanitizer, use:

    meson setup -Db_sanitize=none --wipe build
    meson compile -C build

Note, you should be able to explain WHY you have a data race, and what incorrect
behaviour may happen. The sanity check given to you is **only one** of the
possible unexpected outcomes that may happen.

[pro-git]: https://git-scm.com/book/en/v2/
