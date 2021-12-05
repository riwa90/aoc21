#!/usr/bin/perl/
use warnings;
use strict;
use feature "switch";

# Part 1 solution
sub part1_solution {
	my @input = @_;
	
	my $vertical = 0;
	my $horisontal = 0;

	my $prod;
	my $mag;
	my $dir;

	for my $row (@input) {
		($dir, $mag) = split / /, $row;
		given($dir) {
			when($_ eq "forward") {$horisontal += $mag;}
			when($_ eq "down") {$vertical += $mag;}
			when($_ eq "up") {$vertical -= $mag;}
		}
	}
	$prod = $vertical * $horisontal;
	print "$prod\n";
}

# Part 2 solution
sub part2_solution {
	my @input = @_;
	
	my $vertical = 0;
	my $horisontal = 0;
	my $aim = 0;

	my $prod;
	my $mag;
	my $dir;

	for my $row (@input) {
		($dir, $mag) = split / /, $row;
		given($dir) {
			when($_ eq "forward") {
				$horisontal += $mag;
				$vertical += $mag * $aim;
			 }
			when($_ eq "down") {$aim += $mag;}
			when($_ eq "up") {$aim -= $mag;}
		}
	}
	$prod = $vertical * $horisontal;
	print "$prod\n";
}



my $part = $ENV{part};
open my $fh, "<", "./input.txt" or die;
my @input = <$fh>;

if($part eq "part1") {
	part1_solution(@input);	
} else {
	part2_solution(@input);
}

close $fh;
