#得到了weibull拟合三个参数以后，输入20个label的值得到的，没有多维的probability
use Statistics::Descriptive;
use List::Util qw/sum/;
$wes = 0;
@k = ();
@tao = ();
@lamda = ();
@newdata = ();
open(WEI,shift);
@wei = <WEI>;
#####去掉一些label对应的weibull参数
#splice(@wei,2,1);
#splice(@wei,11,3);
#splice(@wei,14,3);
	#这里现在有19套参数
	for($i==0;$i<=19;$i++){
		@data = split(/\s/,$wei[$i]);
		$k[$i] = $data[0];
		$tao[$i] = $data[2];
		$lamda[$i] = $data[1];
	}
$file = shift;#读取reads的20个参数，不考虑第3，13，14，15，19，20个
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
open(OUT3, ">>LARGEST_OMEGA.txt");
while(<IN>){
	chomp;
	@data = split(/\t/,$_);
	#####去掉对应的输入z值
	#@newdata = ($data[0],$data[1],$data[3],$data[4],$data[5],$data[6],$data[7],$data[8],$data[9],$data[10],$data[11],$data[15],$data[16]);
	%key = {};
	$count += 1;
	$omega0 = 0;
	@old_omega = ();
	for( $i=0;$i<=19;$i++){ ###19个
		$key{$data[$i]} = $i;    #####如果去掉一些label，就改成newdata
	}
	@data1 = sort { $b <=> $a } @data;  ######如果去掉一些label，这里改成@newdata
	print "AFTER SORT: @data1\n";
	for( $i=0;$i<=19;$i++){
		$comp = abs($data1[$i]-$tao[$key{$data1[$i]}]);
		$comp1 = $lamda[2];
		print "ABS: $comp\tLAMBDA: $comp1\n";
		$omega =  1- ((19-$i)/19)*exp(-(abs($data1[$i]-$tao[$key{$data1[$i]}])/$lamda[$key{$data1[$i]}])**$k[$key{$data1[$i]}]);
		push(@old_omega,$omega);
	}
	print "WEIGHTS: @old_omega\n";
	for( $i=0;$i<=19;$i++){
		$omega0 = $omega0 + $data1[$i]*(1-$old_omega[$i]);   ########### NOT EXP WEIGHT V(1-W)
	}
	$new_omega0 = exp($omega0);
	$get_sum = 0;
	@weight = ();
	for ( $i=0;$i<=19;$i++){
		$weight_omega = $old_omega[$i]*$data1[$i];######### USE EXP WEIGHT TO VW
		$weight_omega = exp($weight_omega);   ########### ABANDON EXP AFTER VW
		push(@weight,$weight_omega);
		$get_sum = $get_sum+$weight_omega;
}
	print "WEIGHTED OMEGA: @weight\n";
	$get_sum = $get_sum + $new_omega0;
	print "THE OMEGA0: $new_omega0\n";
	
	@last = ();
	for ( $i=0;$i<=19;$i++){
		$prin_omega = $weight[$i]/$get_sum;
		push(@last,$prin_omega);
}
	$prin_omega0 = $new_omega0/$get_sum;
        push(@last,$prin_omega0);
	@lastsort = sort { $b <=> $a } @last;
	print OUT3 "The LARGEST OPENMAX\t$lastsort[0]\n";
	print "COUNT: $count\n";
	$thre0 = 0;
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
		print "IT IS LARGE!!!!!!!!!!!!!!!\n";
		$thre0 = 1;
                $score0 += 1;
		$thre1 = 1;
                $score1 += 1;
		$thre2 = 1;
                $score2 += 1;
		$thre3 = 1;
                $score3 += 1;
                $thre4 = 1;
                $score4 += 1;
		$thre5 = 1;
                $score5 += 1;
                $thre6 = 1;
                $score6 += 1;
                $thre7 = 1;
                $score7 += 1;
                $thre8 = 1;
                $score8 += 1;
                $thre9 = 1;
                $score9 += 1;
                $thre10 = 1;
                $score10 += 1;

	}
	if($lastsort[0] <= 0.95 &&  $lastsort[0] !=  $prin_omega0) {
                $thre1 = 1;
                $score1 += 1;
        }
       	if($lastsort[0] <= 0.9&&  $lastsort[0] !=  $prin_omega0) {
                $thre2 = 1;
                $score2 += 1;
        }

	if($lastsort[0] <= 0.8&&  $lastsort[0] !=  $prin_omega0) {
		$thre3 = 1;
		$score3 += 1;
	}
	if($lastsort[0] <= 0.7&&  $lastsort[0] !=  $prin_omega0) {
                $thre4 = 1;
                $score4 += 1;
        }
        if($lastsort[0] <= 0.6&&  $lastsort[0] !=  $prin_omega0) {
                $thre5 = 1;
                $score5 += 1;
        }

	if($lastsort[0] <= 0.5&&  $lastsort[0] !=  $prin_omega0) {
                $thre6 = 1;
                $score6 += 1;
        }
	if($lastsort[0] <= 0.4&&  $lastsort[0] !=  $prin_omega0) {
                $thre7 = 1;
                $score7 += 1;
        }
        if($lastsort[0] <= 0.3&&  $lastsort[0] !=  $prin_omega0) {
                $thre8 = 1;
                $score8 += 1;
        }
        if($lastsort[0] <= 0.2&&  $lastsort[0] !=  $prin_omega0) {
                $thre9 = 1;
                $score9 += 1;
        }

        if($lastsort[0] <= 0.1&&  $lastsort[0] !=  $prin_omega0) {
                $thre10 = 1;
                $score10 += 1;
        }

}
open(OUT,">>v4_the_acc_095_to_01_250bp.txt");

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
##not rejected
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
#rejection percent
print OUT "\n$file Rejection Percentage:\t$acc1\t$acc2\t$acc3\t$acc4\t$acc5\t$acc6\t$acc7\t$acc8\t$acc9\t$acc10\n";
#not rejected
open(OUT4,">>the_parameter.txt");
print OUT4 "$count\t$score1\t$score2\t$score3\t$score4\t$score5\t$score6\t$score7\t$score8\t$score9\t$score10\n";
close OUT4;
@this = ($score1,$score2,$score3,$score4,$score5,$score6,$score7,$score8,$score9,$score10);
#@hiv1 = (494492,366264,371537,377715,381964,385658,389209,390306,390861,391021,391048);
open(IN4,"the_parameter.txt");
chomp;
$data4 = <IN4>;
@hiv1 = split(/\t/,$data4);
#@hiv1 = (181613,132544,133979,135633,136807,137797,138748,139003,139072,139078,139078);
@a = ();
@r = ();
@f = ();
print OUT "$file f-meature\t";
for( $i=0;$i<=19;$i++){
	print "$hiv1[$i] \t $this[$i]\n";
	$this =  $hiv1[$i] + $this[$i]; 	
	$a[$i] = $hiv1[$i] /$this; 
	$r[$i] = $hiv1[$i] / 494492 ;
	$f[$i] = $a[$i]*$r[$i]*2/($a[$i]+$r[$i]);
	print OUT "$f[$i]\t";
}
print OUT "\n";
close OUT;
close WES;
close IN;
