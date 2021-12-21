#!/usr/bin/perl/
use strict;
use warnings;

sub part1_solution {
	
	my @input = @_;
	my @result = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

	for my $line (@input) {
		chomp($line);
		for(my $i = 0; $i < length($line); $i++) {
			if(substr($line, $i, 1) eq "1") {
				$result[$i]++;
			} else {
				$result[$i]--;
			}
		} 
	}

	my $firstNumber = "000000000000";
	my $secondNumber = "000000000000";

	for(my $i = 0; $i < scalar(@result); $i++) {
		if($result[$i] > 0) {
			substr($firstNumber, $i, 1) = "1";
			substr($secondNumber, $i, 1) = "0";
		} else {
			substr($firstNumber, $i, 1) = "0";
			substr($secondNumber, $i, 1) = "1";
		}
	}

	$firstNumber = oct("0b" . $firstNumber);
	$secondNumber = oct("0b" . $secondNumber);
	my $finalResult = $firstNumber * $secondNumber;
	print "$finalResult\n";
}

sub create_sublist {
	my($index, @input) = @_;
	my @startWithOne = ();
	my @startWithZero = ();

	for my $line (@input) {
		if(substr($line, $index, 1) eq "1") {
			push @startWithOne, $line;
		} else {
			push @startWithZero, $line;
		}
	}
	return (\@startWithZero, \@startWithOne);	
}

sub part2_least_usual {
	my($index, @input) = @_;
	if(scalar(@input) < 2 || $index > 11) {
		return $input[0];
	}
	
	my($zeroList, $oneList) = create_sublist($index, @input);
	if(scalar(@$zeroList) > scalar(@$oneList)) {
		return part2_least_usual($index + 1, @$oneList);
	} else {
		return part2_least_usual($index + 1, @$zeroList);
	}
}

sub part2_most_usual {
	my($index, @input) = @_;
	if(scalar(@input) < 2 || $index > 11) {
		return $input[0];
	}
	
	my($zeroList, $oneList) = create_sublist($index, @input);
	
	if(scalar(@$zeroList) > scalar(@$oneList)) {
		return part2_most_usual($index + 1, @$zeroList);
	} else {
		return part2_most_usual($index + 1, @$oneList);
	}	
}

sub part2_solution {

	my @input = @_;
	my $mostUsual = part2_most_usual(0, @input);
	my $leastUsual = part2_least_usual(0, @input);
	chomp($mostUsual);
	chomp($leastUsual);
	$mostUsual = oct("0b" . $mostUsual);
	$leastUsual = oct("0b" . $leastUsual);
	my $result = $mostUsual * $leastUsual;
	print "$result\n";
	
}

my $part = $ENV{part};
#my $part = "part2";
open my $fh, "<", "./input.txt" or die;
my @input = <$fh>;

if($part eq "part1") {
	part1_solution(@input);
} else {
	part2_solution(@input);
}

close $fh;

