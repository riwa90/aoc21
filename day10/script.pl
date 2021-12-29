#!/usr/bin/perl/
sub part1_sol {
	my @codeLines = @_;
	my $result = 0;
	my @stack = ();
	my %charValues;
	my %charComplements;
	@charValues{(")", "]", "}", ">")} = (3, 57, 1197, 25137);
	@charComplements{(")", "]", "}", ">")} = ("(", "[", "{", "<");
	for my $codeLine (@codeLines) {
		for my $codeChar (@$codeLine) {
			if(!(exists $charValues{$codeChar})) {
				push @stack, $codeChar;
			} else {
				my $popped = pop @stack;
				unless($popped eq $charComplements{$codeChar}) {
					$result += $charValues{$codeChar};
					last;
				}
			}
		}
		@stack = ();
	}
	print "$result\n";
}

sub part2_sol {
	my @codeLines = @_;
	my $result = 0;
	my @results = ();
	my @stack = ();
	my %charValues;
	my %charComplements;
	@charValues{("(", "[", "{", "<")} = (1, 2, 3, 4);
	@charComplements{(")", "]", "}", ">")} = ("(", "[", "{", "<");
	for my $codeLine (@codeLines) {
		$result = 0;
		@stack = ();
		for my $codeChar (@$codeLine) {
			if(!(exists $charComplements{$codeChar})) {
				push @stack, $codeChar;
			} else {
				my $popped = pop @stack;
				unless($popped eq $charComplements{$codeChar}) {
					@stack = ();
					last;
				}
			}
		}
		for my $stackChar (reverse(@stack)) {
			$result *= 5;
			$result += $charValues{$stackChar};
		}

		push @results, $result unless $result == 0;
	}
	@results = sort {$a <=> $b} @results;
	my $middleIndex = int(scalar(@results) / 2);
	print "$results[$middleIndex]\n"
}

my $part = $ENV{part};
open my $fh, "<", "./input.txt" or die;
my @codeLines = ();
while(<$fh>) {
    my $inputRow = $_;
    chomp($inputRow);
    my @inputRowArray = split "", $inputRow;
    push @codeLines, \@inputRowArray;
}
if($part eq "part1") {
	part1_sol(@codeLines);
} else {
	part2_sol(@codeLines);
}

close $fh;