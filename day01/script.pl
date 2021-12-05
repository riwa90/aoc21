#!/usr/bin/perl
use warnings;
use strict;

my $part = $ENV{part};
my $seq_len = 3;
my $count = 0;

$seq_len = 1 if($part eq "part1");
	
open my $fh, '<',  "./input.txt" or die;
my @input = <$fh>;

for(my $i = $seq_len; $i < scalar @input; $i++) {	
	$count++ if($input[$i - $seq_len] < $input[$i]);
}

print "$count\n";

close($fh);

