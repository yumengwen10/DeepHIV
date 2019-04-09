#得到了weibull拟合三个参数以后，输入20个label的值得到的，没有多维的probability
use Statistics::Descriptive;
use List::Util qw/sum/;
$wes = 0;
@k = ();
@tao = ();
@lamda = ();
open(WEI,shift);
while(<WEI>){
	#if($_ =~ /\d+/){
		@data = split(/\s/,$_);
		$k[$wes] = $data[0];
		$tao[$wes] = $data[2];
		$lamda[$wes] = $data[1];
		$wes += 1;
		#print "k: $data[0] tao:  $data[2]  lamda: $data[1]\n";
	#}
}
$file = shift;
open(IN,$file);
$count = 0;
$score1 = 0;
$score2 = 0;
$score3 = 0;
$score4 = 0;
$score5 = 0;
$score6 = 0;
$score7 = 0;
$score8 = 0;
$score9 = 0;
$score10 = 0;
$score0 = 0;
while(<IN>){
	chomp;
	@data = split(/\t/,$_);
	%key = {};
	#print "@data\n";
	#@sorted = sort { $b <=> $a } @data;
	#print "$data[0]\n";
	$count += 1;
	$omega0 = 0;
	@get_omega =();
	@old_omega = ();
    #sub fisher_yates_shuffle {
    #@my $array = ;
    #my $i;
    #for ($i = @$array; --$i; ) {
     #   my $j = int rand ($i+1);
      #  next if $i == $j;
       # @$array[$i,$j] = @$array[$j,$i];
    #}
#}
	for( $i=0;$i<=19;$i++){
		$key{$data[$i]} = $i;
	}
	@data1 = sort { $a <=> $b } @data;
#	print "AFTER SORT: @data1\n";
	for( $i=0;$i<=19;$i++){		
		#print "$i\t v value:$data[$i]\t k value:$k[$i]\ttao value:$tao[$i]\tlamda value: $lamda[$i]\n";
		#print "yesss $data[$i]-$tao[$i] yesss \n";
		
		$omega =  1-  ((20-$i)/20)*exp(-(abs($data1[$i]-$tao[$key{$data1[$i]}])/$lamda[$key{$data1[$i]}])**$k[$key{$data1[$i]}]);
		#print "YEEEES $omega\t";
		$new_omega = exp($omega);
		#print "$new_omega\n";
		push(@get_omega,$new_omega);
		push(@old_omega,$omega);
		#$record{$i} = $new_omega;
		#print "@get_omega\n";
	
	}
#	print "OMEGA before EXP of 20: @old_omega\n";
	for( $i=0;$i<=19;$i++){
		#print "$omega0\t";
		#print "$j\t$omega0\t$data[$j]\t$get_omega[$j]\n";
		$omega0 = $omega0 + $data1[$i]*(1-$old_omega[$i]);
	}
#	print "THE OMEGA 0 before EXP: $omega0\n";
	$new_omega0 = exp($omega0);
	$get_sum = 0;
	@weight = ();
	for ( $i=0;$i<=19;$i++){
		$weight_omega = $get_omega[$i]*$data1[$i];#weighted !!!!
		push(@weight,$weight_omega);
		$get_sum = $get_sum+$weight_omega;
}
	#print "old sum: $get_sum\n";
	$get_sum = $get_sum + $new_omega0;
#	print "THE SUM after EXP: $get_sum\n";
	
	@last = ();
	for ( $i=0;$i<=19;$i++){
		$prin_omega = $weight_omega[$i]/$get_sum;
		push(@last,$prin_omega);
}
	$prin_omega0 = $new_omega0/$get_sum;
        push(@last,$prin_omega0);
	@lastsort = sort { $b <=> $a } @last;
#print "The LARGEST OPENMAX: $lastsort[0]\n";
	$rej = 0;
	$rej0 = 0;
	$thre = 0;
	$thre1 = 0;
	$thre2 = 0;
	$thre3 = 0;
	$thre4 = 0;
	$thre5 = 0;
	$thre6 = 0;
	$thre7 = 0;
	$thre8 = 0;
	$thre9 = 0;
	$thre10 = 0;
	if( $lastsort[0] ==  $prin_omega0){
		$rej0 = 1;
                $score0 += 1;
	}
	if($prin_omega0 == $lastsort[0] ||  $lastsort[0] ==  $prin_omega0){
		$rej = 1;
		$score += 1;
	}
	if($lastsort[0] <= 0.45 ||  $lastsort[0] ==  $prin_omega0) {
                $thre1 = 1;
                $score1 += 1;
        }
        if($lastsort[0] <= 0.4 ||  $lastsort[0] ==  $prin_omega0) {
                $thre2 = 1;
                $score2 += 1;
        }

	if($lastsort[0] <= 0.35 ||  $lastsort[0] ==  $prin_omega0) {
		$thre3 = 1;
		$score3 += 1;
	}
	if($lastsort[0] <= 0.3 ||  $lastsort[0] ==  $prin_omega0) {
                $thre4 = 1;
                $score4 += 1;
        }
        if($lastsort[0] <= 0.25 ||  $lastsort[0] ==  $prin_omega0) {
                $thre5 = 1;
                $score5 += 1;
        }

	if($lastsort[0] <= 0.2 ||  $lastsort[0] ==  $prin_omega0) {
                $thre6 = 1;
                $score6 += 1;
        }
	if($lastsort[0] <= 0.15 ||  $lastsort[0] ==  $prin_omega0) {
                $thre7 = 1;
                $score7 += 1;
        }
        if($lastsort[0] <= 0.1 ||  $lastsort[0] ==  $prin_omega0) {
                $thre8 = 1;
                $score8 += 1;
        }
        if($lastsort[0] <= 0.05 ||  $lastsort[0] ==  $prin_omega0) {
                $thre9 = 1;
                $score9 += 1;
        }

        if($lastsort[0] <= 0 ||  $lastsort[0] ==  $prin_omega0) {
                $thre10 = 1;
                $score10 += 1;
        }

}
open(OUT,">>weight_small_to_large.txt");
$acc0 = $score0/$count;
$acc = $score/$count;
$acc1 = $score1/$count;
$acc2 = $score2/$count;
$acc3 = $score3/$count;
$acc4 = $score4/$count;
$acc5 = $score5/$count;
$acc6 = $score6/$count;
$acc7 = $score7/$count;
$acc8 = $score8/$count;
$acc9 = $score9/$count;
$acc10 = $score10/$count;

$score1 = $count - $score1;
$score2 = $count - $score2;
$score3 = $count - $score3;
$score4 = $count - $score4;
$score5 = $count - $score5;
$score6 = $count - $score6;
$score7 = $count - $score7;
$score8 = $count - $score8;
$score9 = $count - $score9;
$score10 = $count - $score10;

#print OUT "$file\t$acc0\t$acc1\t$acc2\t$acc3\t$acc4\t$acc5\t$acc6\t$acc7\t$acc8\t$acc9\t$acc10\n";
print OUT "$file\t$count\t$score1\t$score2\t$score3\t$score4\t$score5\t$score6\t$score7\t$score8\t$score9\t$score10\n";
@this = ($score0,$score1,$score2,$score3,$score4,$score5,$score6,$score7,$score8,$score9,$score10);
@hiv1 = (181613,1841,1866,1903,1930,1966,2026,2089,2166,2322,3136);
@a = ();
@r = ();
@f = ();
#print OUT "\n$file\t";
for( $i=0;$i<=19;$i++){
	#print "$hiv1[$i] \t $this[$i]\n";
	$this =  $hiv1[$i] + $this[$i]; 
	
	$a[$i] = $hiv1[$i] /$this; 
	$r[$i] = $hiv1[$i] / 181613 ;
	$f[$i] = $a[$i]*$r[$i]*2/($a[$i]+$r[$i]);
#	print OUT "$f[$i]\t";
}
#print OUT "\n";







close OUT;
close WES;
close IN;
