#!/usr/bin/perl
sub part1_sol {
    my @heightMap = @_;
    my $result = 0;
    my $rowLength = scalar(@heightMap);
    my $colLength = scalar(@{$heightMap[0]});
    for(my $i = 0; $i < $rowLength; $i++) {
        for(my $j = 0; $j < $colLength; $j++) {
            if(checkIfLowest($i, $j, $rowLength, $colLength, @heightMap)) {
                $result += @heightMap[$i]->[$j] + 1;
            }
        }
    }
    print "$result\n";
}

sub checkIfLowest {
    my $x = shift;
    my $y = shift;
    my $xMax = shift;
    my $yMax = shift;
    my @heightMap = @_;
    if($x > 0) {
        if(@heightMap[$x]->[$y] >= @heightMap[$x - 1]->[$y]) {
            return 0;
        }
    }
    if($x < $xMax - 1) {
        if(@heightMap[$x]->[$y] >= @heightMap[$x + 1]->[$y]) {
            return 0;
        }
    }
    if($y > 0) {
        if(@heightMap[$x]->[$y] >= @heightMap[$x]->[$y - 1]) {
            return 0;
        }
    }
    if($y < $yMax - 1) {
        if(@heightMap[$x]->[$y] >= @heightMap[$x]->[$y + 1]) {
            return 0;
        }
    }
    return 1;
}

sub fillBasin {
    my $x = shift;
    my $y = shift;
    my $basinNumber = shift;
    my @heightMap = @_;
    if($x < 0 || $y < 0 || $x > scalar(@heightMap) - 1 || $y > scalar(@{$heightMap[0]}) - 1 || @heightMap[$x]->[$y] != 0) {
        return;
    }
    @heightMap[$x]->[$y] = $basinNumber;
    fillBasin($x - 1, $y, $basinNumber, @heightMap);
    fillBasin($x + 1, $y, $basinNumber, @heightMap);
    fillBasin($x, $y - 1, $basinNumber, @heightMap);
    fillBasin($x, $y + 1, $basinNumber, @heightMap);
}

sub zeroBasins {
    my @heightMap = @_;
    for my $row (@heightMap) {
        for my $depth (@$row) {
            if($depth != 9) {
                $depth = 0;
            }
        }
    }
}

sub findSizesOfBasins {
    my @heightMap = @_;
    my @basinSizes = (0) x 400;
    for my $row (@heightMap) {
        for my $basinNr (@$row) {
            if($basinNr != 9) {
                @basinSizes[$basinNr]++;
            }
        }
    }
    return @basinSizes;
}

sub sumTop3Basins {
    my @basinSizes = @_;
    my @biggestBasins = (0, 0, 0);
    for my $basin (@basinSizes) {
        if($basin > $biggestBasins[2]){
            shift @biggestBasins;
            $biggestBasins[2] = $basin;
        } elsif($basin > $biggestBasins[1]){
            $biggestBasins[0] = $biggestBasins[1];
            $biggestBasins[1] = $basin;
        } elsif($basin > $biggestBasins[0]){
            $biggestBasins[0] = $basin;
        }
    }
    return $biggestBasins[0] * $biggestBasins[1] * $biggestBasins[2];
}

sub part2_sol {
    my @heightMap = @_;
    zeroBasins(@heightMap);
    my $basinNumber = 1;
    for(my $i = 0; $i < scalar(@heightMap); $i++) {
        for(my $j = 0; $j < scalar(@{$heightMap[0]}); $j++) {
            if(@heightMap[$i]->[$j] == 0) {
                fillBasin($i, $j, $basinNumber, @heightMap);
                $basinNumber++;
            }
        }
    }
    my @sizeOfBasins = findSizesOfBasins(@heightMap);
    my $result = sumTop3Basins(@sizeOfBasins);
    print "$result\n";
}

my $part = $ENV{part};
open my $fh, "<", "./input.txt" or die;
my @heightMap = ();
while(<$fh>) {
    my $inputRow = $_;
    chomp($inputRow);
    my @inputRowArray = split "", $inputRow;
    push @heightMap, \@inputRowArray;
}

if($part eq "part1") {
    part1_sol(@heightMap);
} else {
    part2_sol(@heightMap);
}

close $fh;