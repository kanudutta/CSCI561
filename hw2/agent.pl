#!/usr/bin/perl
use strict;
use warnings;

my ($task, $player, $depth, @board, @score, %sequence);
my (%nextstep, %nextstepScore);

&readFile();
&scoreInitialize();
&sequenceInitialize();
&greedy() if $task == 1;
&minimax() if $task == 2;
&alphabeta() if $task == 3;

sub greedy {
    %nextstep = &legitimateStep(\@board, $player);
    %nextstepScore = &getScore(\@board, $player, \@score, \%nextstep);
    my @nextBoard = &copyBoard(\@board);
    my @printBoard;
    my $firstOne = 0;
    for my $keypair (
    sort { $nextstepScore{$b->[0]}{$b->[1]} <=> $nextstepScore{$a->[0]}{$a->[1]} or $sequence{$a->[0]}{$a->[1]} <=> $sequence{$b->[0]}{$b->[1]} }
    map { my $intKey=$_; map [$intKey, $_], keys %{$nextstepScore{$intKey}} } keys %nextstepScore
    ) {
        if($firstOne == 0){
                @printBoard = &changeBoard($player, $keypair->[0], $keypair->[1], \@nextBoard);
        }
        $firstOne ++;
    }
    
    &printBoard(\@printBoard);
}


sub readFile {
    my $inputfile = "input.txt";
    open(IN, "$inputfile") or die "cannot open file $ARGV[0]\n";
    $task = <IN>;
    $player = <IN>;
    $depth = <IN>;
    chomp $task;
    chomp $player;
    chomp $depth;
    my $i = 0;
    while(<IN>){
	chomp;
	my @line = split("", $_);
	for(0..$#line){
	    $board[$i][$_] = $line[$_];
	}
	$i ++;
    }
}

sub scoreInitialize {
    $score[0][0] = 99;
    $score[0][1] = -8;
    $score[0][2] = 8;
    $score[0][3] = 6;
    $score[0][4] = 6;
    $score[0][5] = 8;
    $score[0][6] = -8;
    $score[0][7] = 99;
    $score[1][0] = -8;
    $score[1][1] = -24;
    $score[1][2] = -4;
    $score[1][3] = -3;
    $score[1][4] = -3;
    $score[1][5] = -4;
    $score[1][6] = -24;
    $score[1][7] = -8;
    $score[2][0] = 8;
    $score[2][1] = -4;
    $score[2][2] = 7;
    $score[2][3] = 4;
    $score[2][4] = 4;
    $score[2][5] = 7;
    $score[2][6] = -4;
    $score[2][7] = 8;
    $score[3][0] = 6;
    $score[3][1] = -3;
    $score[3][2] = 4;
    $score[3][3] = 0;
    $score[3][4] = 0;
    $score[3][5] = 4;
    $score[3][6] = -3;
    $score[3][7] = 6;
    $score[4][0] = 6;
    $score[4][1] = -3;
    $score[4][2] = 4;
    $score[4][3] = 0;
    $score[4][4] = 0;
    $score[4][5] = 4;
    $score[4][6] = -3;
    $score[4][7] = 6;
    $score[5][0] = 8;
    $score[5][1] = -4;
    $score[5][2] = 7;
    $score[5][3] = 4;
    $score[5][4] = 4;
    $score[5][5] = 7;
    $score[5][6] = -4;
    $score[5][7] = 8;
    $score[6][0] = -8;
    $score[6][1] = -24;
    $score[6][2] = -4;
    $score[6][3] = -3;
    $score[6][4] = -3;
    $score[6][5] = -4;
    $score[6][6] = -24;
    $score[6][7] = -8;
    $score[7][0] = 99;
    $score[7][1] = -8;
    $score[7][2] = 8;
    $score[7][3] = 6;
    $score[7][4] = 6;
    $score[7][5] = 8;
    $score[7][6] = -8;
    $score[7][7] = 99;
}



sub sequenceInitialize {
    $sequence{0}{0} = 1;
    $sequence{0}{1} = 2;
    $sequence{0}{2} = 3;
    $sequence{0}{3} = 4;
    $sequence{0}{4} = 5;
    $sequence{0}{5} = 6;
    $sequence{0}{6} = 7;
    $sequence{0}{7} = 8;
    $sequence{1}{0} = 9;
    $sequence{1}{1} = 10;
    $sequence{1}{2} = 11;
    $sequence{1}{3} = 12;
    $sequence{1}{4} = 13;
    $sequence{1}{5} = 14;
    $sequence{1}{6} = 15;
    $sequence{1}{7} = 16;
    $sequence{2}{0} = 17;
    $sequence{2}{1} = 18;
    $sequence{2}{2} = 19;
    $sequence{2}{3} = 20;
    $sequence{2}{4} = 21;
    $sequence{2}{5} = 22;
    $sequence{2}{6} = 23;
    $sequence{2}{7} = 24;
    $sequence{3}{0} = 25;
    $sequence{3}{1} = 26;
    $sequence{3}{2} = 27;
    $sequence{3}{3} = 28;
    $sequence{3}{4} = 29;
    $sequence{3}{5} = 30;
    $sequence{3}{6} = 31;
    $sequence{3}{7} = 32;
    $sequence{4}{0} = 33;
    $sequence{4}{1} = 34;
    $sequence{4}{2} = 35;
    $sequence{4}{3} = 36;
    $sequence{4}{4} = 37;
    $sequence{4}{5} = 38;
    $sequence{4}{6} = 39;
    $sequence{4}{7} = 40;
    $sequence{5}{0} = 41;
    $sequence{5}{1} = 42;
    $sequence{5}{2} = 43;
    $sequence{5}{3} = 44;
    $sequence{5}{4} = 45;
    $sequence{5}{5} = 46;
    $sequence{5}{6} = 47;
    $sequence{5}{7} = 48;
    $sequence{6}{0} = 49;
    $sequence{6}{1} = 50;
    $sequence{6}{2} = 51;
    $sequence{6}{3} = 52;
    $sequence{6}{4} = 53;
    $sequence{6}{5} = 54;
    $sequence{6}{6} = 55;
    $sequence{6}{7} = 56;
    $sequence{7}{0} = 57;
    $sequence{7}{1} = 58;
    $sequence{7}{2} = 59;
    $sequence{7}{3} = 60;
    $sequence{7}{4} = 61;
    $sequence{7}{5} = 62;
    $sequence{7}{6} = 63;
    $sequence{7}{7} = 64;
}


sub legitimateStep {
    #input: @board, $player
    
    my @currentBoard = @{shift()};
    my $currentPlayer = shift();
    my %legitimateStep;
    my %xPosition;  #row->column->1;
    my %oPosition;  #row->column->1;
    for (my $i=0; $i <= 7; $i++){
        for (my $j=0; $j <= 7; $j++){
            if($currentBoard[$i][$j] eq "X"){
                $xPosition{$i}{$j} = 1;
            }elsif($currentBoard[$i][$j] eq "O"){
                $oPosition{$i}{$j} = 1;
            }
        }
    }
    if($currentPlayer eq "X"){
        foreach my $row (sort keys %oPosition){
            foreach my $column (sort keys %{$oPosition{$row}}){
                
                next if $row == 7;
                next if $row == 0;
                next if $column == 7;
                next if $column == 0;
     
                # is down available?
                if($currentBoard[$row+1][$column] eq "*"){
                    my $indicator = 0;
                    for (my $xi=$row-1; $xi >=0; $xi --){
                        if (defined $xPosition{$xi}{$column}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row+1}{$column} = 1 if $indicator > 0;
                }
                
                # is up available?
                if($currentBoard[$row-1][$column] eq "*"){
                    my $indicator = 0;
                    for (my $xi=$row+1; $xi <= 7; $xi ++){
                        if (defined $xPosition{$xi}{$column}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row-1}{$column} = 1 if $indicator > 0;
                }
                
                # is left available?
                if($currentBoard[$row][$column-1] eq "*"){
                    my $indicator = 0;
                    for (my $xj=$column+1; $xj <= 7; $xj ++){
                        if (defined $xPosition{$row}{$xj}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row}{$column-1} = 1 if $indicator > 0;
     
                }
                
                # is right available?
                if($currentBoard[$row][$column+1] eq "*"){
                    my $indicator = 0;
                    for (my $xj=$column-1; $xj >= 0 ; $xj --){
                        if (defined $xPosition{$row}{$xj}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row}{$column+1} = 1 if $indicator > 0;
                }
                
                # is lower left available?
                if($currentBoard[$row+1][$column-1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = $row;
                    $minDistance = 7-$column if 7-$column <= $row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $xPosition{$row-$index}{$column+$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row+1}{$column-1} = 1 if $indicator > 0;

                }
                
                # is lower right available?
                if($currentBoard[$row+1][$column+1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = $row;
                    $minDistance = $column if $column <= $row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $xPosition{$row-$index}{$column-$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row+1}{$column+1} = 1 if $indicator > 0;

                }
                
                # is upper left available?
                if($currentBoard[$row-1][$column-1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = 7-$row;
                    $minDistance = 7-$column if 7-$column <= 7-$row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $xPosition{$row+$index}{$column+$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row-1}{$column-1} = 1 if $indicator > 0;
            
                }
                
                # is upper right available?
                if($currentBoard[$row-1][$column+1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = 7-$row;
                    $minDistance = $column if $column <= 7-$row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $xPosition{$row+$index}{$column-$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row-1}{$column+1} = 1 if $indicator > 0;
         
                }
            }
        }
    }elsif($currentPlayer eq "O"){
        foreach my $row (sort keys %xPosition){
            foreach my $column (sort keys %{$xPosition{$row}}){
                
                next if $row == 7;
                next if $row == 0;
                next if $column == 7;
                next if $column == 0;
                
                # is down available?
                if($currentBoard[$row+1][$column] eq "*"){
                    my $indicator = 0;
                    for (my $xi=$row-1; $xi >=0; $xi --){
                        if (defined $oPosition{$xi}{$column}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row+1}{$column} = 1 if $indicator > 0;
                }
                
                # is up available?
                if($currentBoard[$row-1][$column] eq "*"){
                    my $indicator = 0;
                    for (my $xi=$row+1; $xi <= 7; $xi ++){
                        if (defined $oPosition{$xi}{$column}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row-1}{$column} = 1 if $indicator > 0;
                }
                
                # is left available?
                if($currentBoard[$row][$column-1] eq "*"){
                    my $indicator = 0;
                    for (my $xj=$column+1; $xj <= 7; $xj ++){
                        if (defined $oPosition{$row}{$xj}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row}{$column-1} = 1 if $indicator > 0;
                    
                }
                
                # is right available?
                if($currentBoard[$row][$column+1] eq "*"){
                    my $indicator = 0;
                    for (my $xj=$column-1; $xj >= 0 ; $xj --){
                        if (defined $oPosition{$row}{$xj}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row}{$column+1} = 1 if $indicator > 0;
                }
                
                # is lower left available?
                if($currentBoard[$row+1][$column-1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = $row;
                    $minDistance = 7-$column if 7-$column <= $row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $oPosition{$row-$index}{$column+$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row+1}{$column-1} = 1 if $indicator > 0;
                    
                }
                
                # is lower right available?
                if($currentBoard[$row+1][$column+1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = $row;
                    $minDistance = $column if $column <= $row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $oPosition{$row-$index}{$column-$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row+1}{$column+1} = 1 if $indicator > 0;
                    
                }
                
                # is upper left available?
                if($currentBoard[$row-1][$column-1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = 7-$row;
                    $minDistance = 7-$column if 7-$column <= 7-$row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $oPosition{$row+$index}{$column+$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row-1}{$column-1} = 1 if $indicator > 0;
                    
                }
                
                # is upper right available?
                if($currentBoard[$row-1][$column+1] eq "*"){
                    my $indicator = 0;
                    my $minDistance = 7-$row;
                    $minDistance = $column if $column <= 7-$row;
                    for (my $index=0; $index <= $minDistance; $index ++){
                        if (defined $oPosition{$row+$index}{$column-$index}){
                            $indicator ++;
                            last;
                        };
                    }
                    $legitimateStep{$row-1}{$column+1} = 1 if $indicator > 0;
                    
                }
            }
        }
    }
    return %legitimateStep;
}


sub getScore{
    #input: @board, $player, @score, %legitimateStep;
    #output: %legitimateStep;
    
    my @currentBoard = @{shift()};
    my $currentPlayer = shift();
    my @score = @{shift()};
    my %legitimateStep = %{shift()};

    foreach my $row (sort keys %legitimateStep){
        foreach my $column (sort keys %{$legitimateStep{$row}}){
            my @tempBoard = &changeBoard($currentPlayer, $row, $column, \@currentBoard);
            
            ############# get score ############
            my $xScore = 0;
            my $oScore = 0;
            for (my $i=0; $i <= 7; $i++){
                for (my $j=0; $j <= 7; $j++){
                    if($tempBoard[$i][$j] eq "X"){
                        $xScore = $xScore + $score[$i][$j];
                    }elsif($tempBoard[$i][$j] eq "O"){
                        $oScore = $oScore + $score[$i][$j];
                    }
                }
            }
            if($currentPlayer eq "X"){
                $legitimateStep{$row}{$column} = $xScore - $oScore;
            }elsif($currentPlayer eq "O"){
                $legitimateStep{$row}{$column} = $oScore - $xScore;
            }
        }
    }
    return %legitimateStep;
}



sub changeBoard{
    # input: $currentPlayer, $row, $column, @board;
    # output: @changedboard
    my $currentPlayer = shift();
    my $row = shift();
    my $column = shift();
    my @currentBoard = @{shift()};
    my @tempBoard = &copyBoard(\@currentBoard);
    my %xPosition;  #row->column->1;
    my %oPosition;  #row->column->1;
    for (my $i=0; $i <= 7; $i++){
        for (my $j=0; $j <= 7; $j++){
            if($currentBoard[$i][$j] eq "X"){
                $xPosition{$i}{$j} = 1;
            }elsif($currentBoard[$i][$j] eq "O"){
                $oPosition{$i}{$j} = 1;
            }
        }
    }
    if($currentPlayer eq "X"){
        $tempBoard[$row][$column] = "X";
        # is up O?
        for (my $xi=$row-1; $xi >=0; $xi --){
            if (defined $oPosition{$xi}{$column}){
                $tempBoard[$xi][$column] = "X";
            }elsif (defined $xPosition{$xi}{$column}){
                next;
            }else{
                last;
            }
        }
        
        # is down O?
        for (my $xi=$row+1; $xi <= 7; $xi ++){
            if (defined $oPosition{$xi}{$column}){
                $tempBoard[$xi][$column] = "X";
            }elsif (defined $xPosition{$xi}{$column}){
                next;
            }else{
                last;
            }
        }
        
        # is right O?
        for (my $xj=$column+1; $xj <= 7; $xj ++){
            if (defined $oPosition{$row}{$xj}){
                $tempBoard[$row][$xj] = "X";
            }elsif (defined $xPosition{$row}{$xj}){
                next;
            }else{
                last;
            }
        }
        
        # is left O?
        for (my $xj=$column-1; $xj >= 0 ; $xj --){
            if (defined $oPosition{$row}{$xj}){
                $tempBoard[$row][$xj] = "X";
            }elsif (defined $xPosition{$row}{$xj}){
                next;
            }else{
                last;
            }
        }
        
        # is upper right O?
        my $minDistance = $row;
        $minDistance = 7-$column if 7-$column <= $row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $oPosition{$row-$index}{$column+$index}){
                $tempBoard[$row-$index][$column+$index] = "X";
            }elsif (defined $xPosition{$row-$index}{$column+$index}){
                next;
            }else{
                last;
            }
        }
        
        # is upper left O?
        $minDistance = $row;
        $minDistance = $column if $column <= $row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $oPosition{$row-$index}{$column-$index}){
                $tempBoard[$row-$index][$column-$index] = "X";
            }elsif (defined $xPosition{$row-$index}{$column-$index}){
                next;
            }else{
                last;
            }
        }
        
        # is lower right O?
        $minDistance = 7-$row;
        $minDistance = 7-$column if 7-$column <= 7-$row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $oPosition{$row+$index}{$column+$index}){
                $tempBoard[$row+$index][$column+$index] = "X";
            }elsif (defined $xPosition{$row+$index}{$column+$index}){
                next;
            }else{
                last;
            }
        }
        
        # is lower left O?
        $minDistance = 7-$row;
        $minDistance = $column if $column <= 7-$row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $oPosition{$row+$index}{$column-$index}){
                $tempBoard[$row+$index][$column-$index] = "X";
            }elsif (defined $xPosition{$row+$index}{$column-$index}){
                next;
            }else{
                last;
            }
        }
    }elsif($currentPlayer eq "O"){
        $tempBoard[$row][$column] = "O";
        # is up X?
        for (my $xi=$row-1; $xi >=0; $xi --){
            if (defined $xPosition{$xi}{$column}){
                $tempBoard[$xi][$column] = "O";
            }elsif (defined $oPosition{$xi}{$column}){
                next;
            }else{
                last;
            }
        }
        
        # is down X?
        for (my $xi=$row+1; $xi <= 7; $xi ++){
            if (defined $xPosition{$xi}{$column}){
                $tempBoard[$xi][$column] = "O";
            }elsif (defined $oPosition{$xi}{$column}){
                next;
            }else{
                last;
            }
        }
        
        # is right X?
        for (my $xj=$column+1; $xj <= 7; $xj ++){
            if (defined $xPosition{$row}{$xj}){
                $tempBoard[$row][$xj] = "O";
            }elsif (defined $oPosition{$row}{$xj}){
                next;
            }else{
                last;
            }
        }
        
        # is left X?
        for (my $xj=$column-1; $xj >= 0 ; $xj --){
            if (defined $xPosition{$row}{$xj}){
                $tempBoard[$row][$xj] = "O";
            }elsif (defined $oPosition{$row}{$xj}){
                next;
            }else{
                last;
            }
        }
        
        # is upper right X?
        my $minDistance = $row;
        $minDistance = 7-$column if 7-$column <= $row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $xPosition{$row-$index}{$column+$index}){
                $tempBoard[$row-$index][$column+$index] = "O";
            }elsif (defined $oPosition{$row-$index}{$column+$index}){
                next;
            }else{
                last;
            }
        }
        
        # is upper left X?
        $minDistance = $row;
        $minDistance = $column if $column <= $row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $xPosition{$row-$index}{$column-$index}){
                $tempBoard[$row-$index][$column-$index] = "O";
            }elsif (defined $oPosition{$row-$index}{$column-$index}){
                next;
            }else{
                last;
            }
        }
        
        # is lower right X?
        $minDistance = 7-$row;
        $minDistance = 7-$column if 7-$column <= 7-$row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $xPosition{$row+$index}{$column+$index}){
                $tempBoard[$row+$index][$column+$index] = "O";
            }elsif (defined $oPosition{$row+$index}{$column+$index}){
                next;
            }else{
                last;
            }
        }
        
        # is lower left X?
        $minDistance = 7-$row;
        $minDistance = $column if $column <= 7-$row;
        for (my $index=0; $index <= $minDistance; $index ++){
            if (defined $xPosition{$row+$index}{$column-$index}){
                $tempBoard[$row+$index][$column-$index] = "O";
            }elsif (defined $oPosition{$row+$index}{$column-$index}){
                next;
            }else{
                last;
            }
        }
    }
    return @tempBoard;

}


sub copyBoard{
    # input: @board
    my @inBoard = @{shift()};
    my @outBoard;
    for (my $i=0; $i <= 7; $i++){
        for (my $j=0; $j <= 7; $j++){
            $outBoard[$i][$j] = $inBoard[$i][$j];
        }
    }
    return @outBoard;
}


sub printBoard{
    # input: @board
    my @inBoard = @{shift()};
    for (my $i=0; $i <= 7; $i++){
        for (my $j=0; $j <= 7; $j++){
            print "$inBoard[$i][$j]";
        }
        print "\n";
    }
}









