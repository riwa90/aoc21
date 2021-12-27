#!/usr/bin/perl
use strict;
use warnings;

sub findFrequencyOfValues {
    my @input = @_;
    my @frequency = (0) x 2000;
    for my $value (@input) {
        $frequency[$value]++;
    }
    return @frequency;
}

sub findMedian {
    my $medianIndex = shift;
    my $frequencies = shift;
    my $currentIndex = 0;
    my $value = -1;
    while($currentIndex < $medianIndex) {
        $currentIndex += @$frequencies[++$value];
    }
    return $value;
}

sub calcTotDistFromMedian {
    my $median = shift;
    my $distances = shift;
    my $sumOfDist = 0;
    for my $dist (@$distances) {
        $sumOfDist += abs($dist - $median);
    }
    return $sumOfDist;
}

sub calcAvg {
    my $nrOfValues = shift;
    my $values = shift;
    my $sum = 0;
    for my $value (@$values) {
        $sum += $value;
    }
    return int($sum / $nrOfValues);
}

sub calcTotExpDistFromAverage {
    my $avg = shift;
    my $distances = shift;
    my $sumOfDist = 0;
    my $curDist;
    my $curCost;
    #print "Average is: $avg\n";
    for my $dist (@$distances) {
        #print "For dist: $dist\n";
        $curCost = 0;
        $curDist = abs($dist - $avg);
        foreach((1 .. $curDist)) {
            $curCost += $_;
        }
        #print "the current cost is: $curCost\n";
        $sumOfDist += $curCost;
    }
    return $sumOfDist;
}

my $part = $ENV{part};
open my $fh, "<", "./input.txt" or die;
my @input = <$fh>;
@input = split /,/, $input[0];
my $result = 0;
if($part eq "part1") {
    my @frequency = findFrequencyOfValues(@input);
    my $medianIndex = int((scalar(@input) / 2) + 0.5);
    my $median = findMedian($medianIndex, \@frequency);
    $result = calcTotDistFromMedian($median, \@input);
} else {
    my $avg = calcAvg(scalar(@input), \@input);
    $result = calcTotExpDistFromAverage($avg, \@input);
}

print "$result\n";
close $fh;