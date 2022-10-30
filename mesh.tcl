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



$ns color 1 Green



set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]

set n3 [$ns node]



$ns duplex-link $n0 $n1 1Mb 10ms DropTail

$ns duplex-link $n1 $n2 1Mb 10ms DropTail

$ns duplex-link $n2 $n3 1Mb 10ms DropTail

$ns duplex-link $n0 $n3 1Mb 10ms DropTail

$ns simplex-link $n0 $n2 1Mb 10ms DropTail



set udp [new Agent/UDP]

$udp set fid_ 1

$ns attach-agent $n0 $udp 

set cbr [new Application/Traffic/CBR]

$cbr attach-agent $udp



set sinkUDP [new Agent/Null]

$ns attach-agent $n2 $sinkUDP

$ns connect $udp $sinkUDP

puts "CBR packet size = [$cbr set packet_size_]"

$ns at 1.0 "$cbr start"

$ns at 4.0 "$cbr stop"

$ns at 6.0 "finish"



$ns run