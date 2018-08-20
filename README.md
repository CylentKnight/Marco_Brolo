# Marco_Brolo
BLUF: An alert triggering engine for bro. The goal is to provide a level of automation to active hunt efforts.

SUMMARY
Marco Brolo is a triggering engine for bro. Defensive analysts or systems administrators that find themselves running the same one-line commands against archived BroLogs should find this tool useful. The script has 2 primary parts, marco and brolo. Marco is a simple text file where users can put their commands in which are parsed and ran against the archived bro log every hour. The alert options can be recoded to meet your specific needs but in it's planned state, it will work with pcapitate to automatically pull a pcap sample for later review/evidence collection.

The commands that users can input vary from simple grep, cut commands to complex awk searches. It will have built in safety features which will prevent the collection of pcap in the event a rule fires to often which will be user configurable via brolo.conf. After the safety cap is reached, the rule will stop collecting pcap but still increment the rules statistics.
