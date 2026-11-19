pktmon stop
pktmon list

pktmon filter remove
pktmon filter add -p 9
pktmon filter add -p 65535

pktmon start --etw -m real-time