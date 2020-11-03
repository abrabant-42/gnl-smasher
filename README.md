# gnl-smasher
![](https://i.imgur.com/0UWAtlh.png)


**gnl-smasher** is a test framework that will help you find bugs and test the features of your get_next_line project. It is mostly made of bash scripts and pure C, and provides several information about your failed tests to help you find out what the bugs are.


**This framework has been built for the 2020 version of the project, and therefore expects two files: `get_next_line.c` and `get_next_line_utils.c`**.


The subject used as reference is available at the root of the repository.

# Map
1. Usage
2. Features

## Usage

I designed this framework to be the most user-friendly possible. The only thing you have to do is to clone this repository, make the `smasher.sh` executable, and type the command `smasher.sh` or `smasher.sh help` to see all the available commands.


You''ll also have to have the path to your `get_next_line` properly set in `gnl_smasher.config`.


As a quick start, simply perform the following command:
```bash
./smasher.sh run
```
or
```bash
./smasher.sh run --nobonus
```
if you don't want to include the bonus tests, for example.

Extensive configuration is available through other command line flags, please refer to the output of the `help` command.

## Features

**gnl-smasher** consists in a small set of tests, designed to highlight the potential errors and pitfalls related to your `get_next_line` function. I think there's no need for a hundred of tests until it is really necessary, however I will be glad to hear you if you have some suggestions or found other errors that this framework do not cover yet.


At the moment, the framework provides testing for:

- Basic errors and pitfalls (multiple lines, big lines, empty lines, empty file, file not ending with a newline, and so on...)
- Handling of multiple file descriptors: one test is available and should cover everything needed to ensure you're correct.
- Complete logging and deepthought generation: you can easily retrieve your output, the expected output, and the difference between the two under the `out` directory (automatically created when you run the script). The deepthought is a great way of summarizing this, and is configurable by specifying options.

- **Now what this framework doesn't do (and for good reasons)**

- DOES NOT check the norm: due to the COVID-19, most people are working from home now, and the norminette executable can be difficult to find depending on the configuration of the environment - you can run the norm check yourself.

- DOES NOT	check the leaks: your project must not produce any leak, but **gnl-smasher** doesn't check that, at least at the moment. I personally recommend to use the `valgrind` utility, whether you're on Linux or Mac (and if you're on Windows, well good luck). Alternatives are the `fsanitize` compiler's flag and the `leaks` command in case you're on Mac. However, I do not use these so have nothing special to say about it.

- DOES NOT check for the first bonus requirement, that is: "only use one static variable". This is simply because it is not a really easy thing to parse, because you can easily get false positives by declaring a function `static` or even by including the `static` keyword in comments. It can be done, but that's really problematic to implement, mostly for something you are forced to be aware of (unless you copied/pasted code from github !)
