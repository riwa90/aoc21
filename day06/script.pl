#!/usr/bin/perl
use strict;
use warnings;

my $part = $ENV{part};
open my $fh, "<", "./input.txt" or die;
my @input = <$fh>;
my @inputFish = split /,/, $input[0];
my @fish = (0, 0, 0, 0, 0, 0, 0, 0, 0);
for my $number (@inputFish) {
    $fish[$number]++;
}
my $daysForSimulation = 256;
$daysForSimulation = 80 if($part eq "part1");
my $fishGivingBirth = 0;
for(my $i = 0; $i < $daysForSimulation; $i++) {
    $fishGivingBirth = shift @fish;
    @fish[8] = $fishGivingBirth;
    $fish[6] += $fishGivingBirth;
}
my $sum = 0;
for my $number (@fish) {
    $sum += $number;
}
print "$sum\n";

close $fh;