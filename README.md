Introduction
============

Sometimes it's necessary to document the project :). And when there is an issue
like: "to write comments with volume 30% of code lines", it would be great
to have a tool that can calculate lines of code, lines of comments and their
percentage ratio.

There is the standart rake task `rake stats`, but it doesn't calculate
commented lines count. So I've wrote this simple rake task. Now it works
only for `app/controllers`, `app/helpers` and `app/models` directories.

Usage
=====

Just add the file `comments_percentage.rake` to your `lib/tasks` directory and run:

    rake commented

Sample output:

    controllers:
    -- code = 824
    -- comments = 168
    -- commented = 20%

    helpers:
    -- code = 487
    -- comments = 56
    -- commented = 11%

    models:
    -- code = 1846
    -- comments = 1090
    -- commented = 59%

    total:
    -- code = 3157
    -- comments = 1314
    -- commented = 41%
