set ns [new Simulator]

set nf [open out3.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out3.nam &
exit 0
}

$ns color 1 blue
$ns color 2 green
$ns color 3 red

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n1 2Mb 10ms DropTail
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n0 $n3 2Mb 10ms DropTail

set tcp1 [new Agent/TCP]
$tcp1 set fid_ 1
$ns attach-agent $n0 $tcp1
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp1

set sinkTCP3 [new Agent/TCPSink]
$ns attach-agent $n1 $sinkTCP3
$ns connect $tcp1 $sinkTCP3

set tcp2 [new Agent/TCP]
$tcp2 set fid_ 2
$ns attach-agent $n0 $tcp2
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp2

set sinkTCP4 [new Agent/TCPSink]
$ns attach-agent $n2 $sinkTCP4
$ns connect $tcp2 $sinkTCP4

set tcp3 [new Agent/TCP]
$tcp3 set fid_ 3
$ns attach-agent $n0 $tcp3
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp3

set sinkTCP6 [new Agent/TCPSink]
$ns attach-agent $n3 $sinkTCP6
$ns connect $tcp3 $sinkTCP6


$ns at 0.5 "$ftp0 start"
$ns at 4.0 "$ftp0 stop"

$ns at 0.5 "$ftp1 start"
$ns at 4.0 "$ftp1 stop"

$ns at 0.5 "$ftp2 start"
$ns at 4.0 "$ftp2 stop"

$ns at 5.0 "finish"

$ns run