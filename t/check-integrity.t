#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;
use Path::Tiny qw/ path /;

{
    my @int_nums = path("Int3.txt")->lines_raw({ chomp => 1});
    my $ok = 1;
    INT:
    foreach my $idx (0 .. $#int_nums - 1)
    {
        if ($int_nums[$idx] >= $int_nums[$idx+1])
        {
            $ok = 0;
            diag("nums $idx are not sorted.");
            last INT;
        }
    }
    # TEST
    ok( $ok, "Nums are sorted.");
}

