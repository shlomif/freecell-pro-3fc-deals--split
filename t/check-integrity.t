#!/usr/bin/perl

use strict;
use warnings;
use autodie;

use Test::More tests => 861;
use Path::Tiny qw/ path /;

{
    my @int_nums = path("Int3.txt")->lines_raw( { chomp => 1 } );
    my $ok       = 1;
INT:
    foreach my $idx ( 0 .. $#int_nums - 1 )
    {
        if ( $int_nums[$idx] >= $int_nums[ $idx + 1 ] )
        {
            $ok = 0;
            diag("nums $idx are not sorted.");
            last INT;
        }
    }

    # TEST
    ok( $ok, "Nums are sorted." );

    my %intract;
    @intract{@int_nums} = ();
    foreach my $fh ( path("Imp3/")->children(qr/XXXXXXX\.txt\z/) )
    {
        my $bn   = $fh->basename;
        my $bn2  = $bn  =~ s#\.txt\z##r;
        my $s_re = $bn2 =~ s/X/[0-9]/gr;
        my $re   = qr#\A$s_re\z#;
        my $min  = int( $bn2 =~ s/X/0/gr );
        my $max  = int( $bn2 =~ s/X/9/gr );

        my $last = -1;
        my $in   = $fh->openr_raw;
        while ( my $i = <$in> )
        {
            chomp $i;
            if ( $i <= $last )
            {
                fail("$i is not ordered in $bn");
                die "foo";
            }
            if ( exists $intract{$i} )
            {
                fail("$i is intractable in $bn");
                die "int";
            }
            $last = $i;
        }
        my $first;
        {
            open my $in2, "<:raw", $fh;
            $first = <$in2>;
            chomp $first;
            close $in2;
        }
        unless ( ( $first >= $min ) and ( $last <= $max ) )
        {
            fail("$first/$last are out of range in $bn");
            die "out";
        }

        # TEST*859
        pass("$bn is ok.");
    }

    # TEST
    pass("All range files are fine.");
}
