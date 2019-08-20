open(TEST,shift);
while(<TEST>){
	chomp;
	if($_ =~ /\[/){
		$begin = $_;
		$second = <TEST>;
		$third = <TEST>;
		$all = $begin.$second.$third;
		$all =~ s/\s+//g;
		$all =~ s/\t//g;
		$all =~ s/\n//g;
		#print "$all\n";
		@data = split(/\,|\[|\]/,$all);
		for($i=1;$i<@data;$i++){
			#$data[$i] =~ s/\s//g;
			if($data[$i] =~ /\d+/){
				print "$data[$i]\t";
			}
		}
		print "\n";
	}
}
