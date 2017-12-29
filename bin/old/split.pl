#!/usr/bin/perl

use strict;
use warnings;

use Path::Tiny qw/ path /;

open my $in, '<', 'freecell-pro-3fc-deals/Imp3.txt';
my $old_fn;
my $fh;
while (my $l = <$in>)
{
    my $z = sprintf("%010d", int $l);
    my $fn = "freecell-pro-3fc-deals--split/Imp3/" . substr($z, 0, 3) . "XXXXXXX.txt";
    if ($fn ne $old_fn)
    {
        $old_fn = $fn;
        $fh = path($fn);
    }
    $fh->append($l);
}
