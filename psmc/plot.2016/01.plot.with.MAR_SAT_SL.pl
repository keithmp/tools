# plot are scaled to by :
# $mu="1.25e-8"; # mutations per nucleotide per generation
# $generation_time="30"; # year


my @in=@ARGV;
die "$0 AFR.ACB.male.hc.txt AMR.MXL.female.hc.txt ...\n"unless @in;


open(O,"> $0.gnuplot");
print O qq(
set size 2.3688, 1.1688;
set xran [10000:10000000];
set log x;
set format x "10^{%L}";
set mxtics 10;
set mytics 10;
unset grid;
set key right top;
set xtics font "Helvetica,22";
set ytics nomirror font "Helvetica,22";
set y2tics nomirror font "Helvetica,22";
set my2tics 10;
set xlab "Years (g=30, {/Symbol m}=1.25x10^{-8})" font "Helvetica,22";
set t po eps enhance so co "Helvetica,20";
set yran [0:10];
set y2tics
set ylab "Effective population size (x10^4)" font "Helvetica,22";
set y2ran [-18:50]
set y2label "Surface air temperature({/Symbol <B0>}C) \\n or global sea level(m) \\n or MAR (g/cm^3/1,000 years)" font "Helvetica,22" rotate by 270 offset 1,0;
  set style line 1 lt 1 lc rgb  "#FF0000" lw 4;
  set style line 2 lt 1 lc rgb  "#00C000" lw 4;
  set style line 3 lt 1 lc rgb  "#0080FF" lw 4;
  set style line 4 lt 1 lc rgb  "#C000FF" lw 4;
  set style line 5 lt 1 lc rgb  "#00EEEE" lw 4;
  set style line 6 lt 1 lc rgb  "#C04000" lw 4;
  set style line 7 lt 1 lc rgb  "#C8C800" lw 4;
  set style line 8 lt 1 lc rgb  "#FF80FF" lw 4;
  set style line 9 lt 1 lc rgb  "#4E642E" lw 4;
  set style line 10 lt 1 lc rgb "#800000" lw 4;
  set style line 11 lt 1 lc rgb "#67B7F7" lw 4;
  set style line 12 lt 1 lc rgb "#FFC127" lw 4;
  set style line 100 lt 13 lc rgb "grey" lw 4;
  set style line 101 lt 0 lc rgb "grey" lw 4;
  set style line 102 lt 0 lc rgb "black" lw 4;
  set output "$0.eps" ;
  plot );


for(my $i=0;$i<@in;$i++){
    my $num=$i+1;
    print O qq("$in[$i]" u 1:2 t "$in[$i]" w st ls $num, );
}
print O qq("bintanja2008.txt.nohead.tab.SurfaceTemp.txt" u 1:2 t "SAT" w st ls 101 axes x1y2,"bintanja2008.txt.nohead.tab.SeaLevl.txt" u 1:2 t "GSL" w st ls 100 axes x1y2,"2005_mar.txt" u 1:2 t "MAR" w st ls 102 axes x1y2;);

close O;

`gnuplot $0.gnuplot`;
`epstopdf.pl $0.eps`;
`rm $0.eps`;
