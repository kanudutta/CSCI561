#!/usr/bin/perl
# CSCI-561 Fall 2014 homework 1
#

use strict;

my $out = "output.txt";
open(OUT, ">$out") or die "cannot open output file\n";
print OUT "CSCI-561 rocks!\n";