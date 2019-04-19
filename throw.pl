open(FILE,shift);
chomp;
@file = <FILE>;
close FILE;

open(IN,shift);
chomp;
$throw = <IN>;
@res = <IN>;
@order =[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
for($i=0;$i<@res;$i++){
	@data = split(/\,|\[|\]/,$res[$i]);
	$num = $data[0];
	$true = $data[2];
	$pre = $data[4];
	if ($true eq $pre){
		#print "YESSSSS";
		$pri = $file[$i];
		@data_pri = split(/\t/,$pri);
		@sorted = sort { $b <=> $a } @data_pri;
        	$maxi = $sorted[0];
		print "$num\t$true\t$maxi\n";
		#for($i=0;$i<=19;$i++){
		#	if($true == $i){
		#		print OUT 
			
		}
	}
