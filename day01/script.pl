#!/usr/bin/perl
use warnings;
use strict;

my $input_path = "./input1.txt";

open my $fh, '<', $input_path or die;
my @input = <$fh>;
my $count_part1 = my $count_part2 = 0;

$count_part1++ if(@input[0] < @input[1]);

$count_part1++ if(@input[1] < @input[2]);

for(my $i = 3; $i < scalar @input; $i++) {
	
	$count_part1++ if(@input[$i - 1] < @input[$i]);
	$count_part2++ if(@input[$i - 3] < @input[$i]);
}

print "Number of increases of sequential values: $count_part1\n";
print "Number of increases of sequential 3-value sums: $count_part2\n";

close($fh);
