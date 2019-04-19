open(IN,shift);
while(<IN>){
	chomp;
	@data = split(/\s+/,$_);
	$_ =~ s/\s+//g;
        $_ =~ s/\t//g;
        $_ =~ s/\n//g;
	#@data = split(/\s+/,$_);
	#$data[0] =~ s/\s+//g;
	#$data[0] =~ s/\t//g;
	#$data[0] =~ s/\n//g;
	if($_!~ /[a-z]/){
		print "$data[0]\t$data[1]\t$data[2]\n";
		}
	}

close IN;
