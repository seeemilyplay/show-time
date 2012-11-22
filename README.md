show-time
====================

This is an executable that is handy if you have to parse a file with lots of timestamps in it.

To install the executable just do 'cabal install'.

Now say you have a file called sample.txt which contains some timestamps mixed in with other stuff like this:

[2012-11-22 13:30.02] (23112): Skipped 1349398800 1349402400 3600
[2012-11-22 13:30.02] (23112): Skipped 1349402400 1349406000 3600
[2012-11-22 13:30.02] (23112): Skipped 1349406000 1349409600 3600

You can use show-time to display the times by running:

$ cat sample.txt | show-time

Which outputs to the stdout:

[2012-11-22 13:30.02] (23112): Skipped {1349398800|2012-10-05 01:00:00} {1349402400|2012-10-05 02:00:00} 3600
[2012-11-22 13:30.02] (23112): Skipped {1349402400|2012-10-05 02:00:00} {1349406000|2012-10-05 03:00:00} 3600
[2012-11-22 13:30.02] (23112): Skipped {1349406000|2012-10-05 03:00:00} {1349409600|2012-10-05 04:00:00} 3600

The original values are shown side-by-side with the parsed times. The times are shown in GMT/UTC.

It will convert any number into a time, if that time occurs within 10 years of the current date.  If you want to change that number just pass it in as an argument:

$ cat sample.txt | show-time 20
