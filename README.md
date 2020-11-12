# gnl-smasher
![](https://i.imgur.com/0UWAtlh.png)


**gnl-smasher** is a test framework that will help you find bugs and test the features of your get_next_line project. It is mostly made of bash scripts and pure C, and provides information about your failed tests to help you find out what the bugs are.


**This framework has been built for the 2020 version of the project, and therefore expects two files: `get_next_line.c` and `get_next_line_utils.c` as well as their bonus variants.**.


The subject used as reference is available at the root of the repository.

## Usage

I designed this framework to be the most user-friendly possible. The only thing you have to do is to clone this repository, make the `smasher.sh` executable, and type the command `smasher.sh` or `smasher.sh help` to see all the available commands.


You''ll also need to have the path to your `get_next_line` properly set in `gnl_smasher.config`.

## Quick start

```bash
# run standard tests
./smasher.sh run

# run standard tests and multi-fd test
./smasher.sh run --bonus

# specify a custom buffer size
./smasher.sh run --bfz=10000
```

## Troubleshooting

### The tester is slow

This is perfectly possible, and this is often due to the "big" tests, that
may take a long time especially if you're testing your code with a small
BUFFER_SIZE. If this is a problem for you, just try to run the tests using a
bigger BUFFER_SIZE. Moreover, using the `--valcheck` option will rerun your
code two times, so it'll take longer.

### The tester is stuck

The runtime of your code is not limited by the tester, then it will not do
anything if your code is experiencing issues like infinite loops. This is your
duty to verify that such issues are not present.

### I have another issue(s)

The framework should give you enough information to let your figure out
errors that are coming from your project. However, some bugs may be present,
especially with options that are depending on external tools like `--valcheck`
that uses `valgrind`.


I'm not actively maintaining my test frameworks, but you can always open an
issue if you're running into trouble. I'll try to give it a look and fix it
when I'll have time.
