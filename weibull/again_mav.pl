use Statistics::Descriptive;
use List::Util qw/sum/;
$num = 0; ###label从0开
$count = 0;
$sum = 0;
@arr= ();
@distan = ();
open(IN,shift);
@in = <IN>;
push(@in,"end");
for($i=0;$i<=@in;$i++){
#while(<IN>){
	@data = split(/\t/,$in[$i]);
	if($data[1] == $num){
		#print "YESSSS";
		push(@arr,$data[2]);
		$sum = $sum + $data[2];
		$count += 1;
	}
	if($data[1] != $num){
		#print "The $num label : \n";
		$mean = $sum/$count;
		#print "$num\t$mean\n";
		foreach $j(@arr){
			$dis = abs($j-$mean);
			push(@distan,$dis);
		}
		#print "@distan\n";
		@sort = sort { $b <=> $a } @distan;
		#print "sort $sort[0]\n";
        	for($k=0;$k<=20;$k++){
			$prin = $sort[$k];
			print "$prin\t";
		}
		print "\n";
		$sum = 0;
		$count = 0;
		@arr = ();
		@sort = ();
		@distan = ();
		$num = $data[1];
	}

}
