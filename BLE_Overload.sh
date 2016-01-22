#! /bin/bash
# --------------------------------------------------------
# Script simulates a group of Keiser M3i bike using HCI.
# --------------------------------------------------------
# This tool is designed to test against a large group of 
# signals at an unrealistic interval.
# --------------------------------------------------------

RATE="A0 00" # 100ms

MAJOR="06"
MINOR="24"
DATATYPE="00"
RPM="00 00"
HR="00 00"
POWER="00 00"
KCAL="00 00"
MINUTES="00"
SECS="00"
TRIP="00 00"
GEAR="01"

HCICOUNT=7;

DECPOWER=0

function init {
	COUNTER=0
	while [ $COUNTER -lt $HCICOUNT ]; do
		HCIDEVICE="hci$COUNTER";
		hciconfig $HCIDEVICE down > /dev/null;
		hciconfig $HCIDEVICE up > /dev/null;
		hcitool -i $HCIDEVICE cmd 0x08 0x000A 00 > /dev/null;
		hcitool -i $HCIDEVICE cmd 0x08 0x0006 $RATE  $RATE  03  00  00  00 00 00 00 00 00 07 00 > /dev/null;
		hcitool -i $HCIDEVICE cmd 0x08 0x0008 1C 03 09 4D 33 02 01 04 14 FF 02 01 $MAJOR $MINOR $DATATYPE $BIKEID $RPM $HR $POWER $KCAL $MINUTES $SECS $TRIP $GEAR > /dev/null;
		hcitool -i $HCIDEVICE cmd 0x08 0x000A 01 > /dev/null;
		let COUNTER=COUNTER+1;
	done
}

function set_broadcast {
	COUNTER=0
	while [ $COUNTER -lt $HCICOUNT ]; do
		HCIDEVICE="hci$COUNTER";
		BIKEID="0$COUNTER";
		hcitool -i $HCIDEVICE cmd 0x08 0x0008 1C 03 09 4D 33 02 01 04 14 FF 02 01 $MAJOR $MINOR $DATATYPE $BIKEID $RPM $HR $POWER $KCAL $MINUTES $SECS $TRIP $GEAR > /dev/null;
		let COUNTER=COUNTER+1;
	done
}

function run {
    init
    while true; do
        sleep .500
        DECPOWER=$[$DECPOWER + 2]
        if [ $DECPOWER -ge 255 ]; then
            DECPOWER=0;
        fi
        POWER="$(printf "%02x" $DECPOWER) 00"
        set_broadcast
    done
}

run;