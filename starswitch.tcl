#start topology

set ns [new Simulator]
set nf [open out5.nam w]

$ns color 1 Red
$ns color 2 Green
$ns namtrace-all $nf

proc finish {} {
   global ns nf
   $ns flush-trace
   close $nf
   exec nam out5.nam &
   exit 0
}

set a [$ns node]
set b [$ns node]
set c [$ns node]
set d [$ns node]
set e [$ns node]

$ns duplex-link $a $b 2Mb 10ms DropTail
$ns duplex-link $a $c 2Mb 10ms DropTail
$ns duplex-link $a $d 2Mb 10ms DropTail
$ns duplex-link $a $e 2Mb 10ms DropTail

set udp [new Agent/UDP]
$udp set fid_ 1

$ns attach-agent $a $udp

set cbr [new Application/Traffic/CBR]
$cbr set packetsize_ 500 
$cbr attach-agent $udp

set udpnull [new Agent/Null]
$ns attach-agent $c $udpnull
$ns connect $udp $udpnull

#set tcpsink [new Agent/TCPSink]
#$ns attach-agent $c $tcpsink
#$ns connect $tcp $tcpsink

$ns at 1.0 "$cbr start"
$ns at 3.0 "$cbr stop"
$ns at 4.0 "finish"

$ns run