#!/bin/bash

#GOTTA CHECK AND SEE IF THEY HAVE XCODE TOOLS!!!!
echo "



"
echo -n "Are Xcode Command Line Tools Installed?  (y/n)"
read xcode
if [ xcode = "n" ]
then
echo -n "
[*]		Install Now? (y/n)

"
read ubtr

	if [ $ubtr = "y" ]
	then
	xcode-select --install > /dev/null 2>&1
	else
	exit
	fi

fi



#LITTLE VERIFICATION TO CONFIGURE!!!

echo -n "Ready To Configure. (Press Return)"
read ready

if [ ready = "" ]
then

echo "[Step 0]		Starting Configuration......"

fi

#OKAY DOKKAY!

#GETS WGET USING CURL


#CHECKS FOR WGET

if [ -f "/usr/local/bin/wget" ]
then
wget=0 
else
wget=1 
fi

echo "[STEP 1]		Checking For WGET......"

if [ $wget = "0" ] 

then

#IF WE HAVE WGET...

echo "[*]							good to go"

else

# IF WE DONT HAVE WGET

echo "[*]		WGET......yes"
echo "[*]		Downloading wget......"
cd $HOME
curl -O 'http://ftp.gnu.org/gnu/wget/wget-1.13.4.tar.gz' > /dev/null 2>&1 && echo "[*]		Done......"
echo "[*]		Uncompressing......"
tar -xzf wget-1.13.4.tar.gz && echo "[*]		Done......"
cd wget-1.13.4
echo "[*]		Configuring......"
./configure --with-ssl=openssl > /dev/null 2>&1 && echo "[*]		Done......"
sleep 2
echo "[*]		Making......"
make > /dev/null 2>&1
echo "[*]		Done......"
echo "[*]		Installing......"
sudo make install > /dev/null 2>&1 && echo "[*]		Done......"
echo "[*]		Checking......"
	if [ -f "/usr/local/bin/wget" ]
	then
	echo "[*]		Good To Go: wget Installed......"
	
	else
		echo "[*]		wget Install Falied......"
		echo "[*]		Try Visiting 'http://ftp.gnu.org/gnu/wget' To Install Manually."
		echo "[*]		********WGET IS REQUIRED TO CONTINUE INSTALLATION!********"
		exit
	fi
	

fi

#INSTALLING SSHPASS

# Set Variable For Already Installed 
if [ -f "/usr/local/bin/sshpass" ]
then
sshpass=0 
else
sshpass=1 
fi

#End

# Start If Statement For Installing Or Not

echo "[STEP 2]		Checking For SSHPASS......"
if [ $sshpass = "0" ] 
then
echo "[*]							good to go"
else
echo "[*]		SSHPASS......no"
echo "[*]		Downloading......"
cd $HOME
wget 'http://sourceforge.net/projects/sshpass/files/latest/download -O sshpass.tar.gz' && echo "[*]		Done......"
echo "[*]		Done......"
echo "[*]		Uncompressing......"
sleep 2
tar -zxvf sshpass-1.05.tar.gz >/dev/null && echo "[*]		Done......"
sleep 2
cd sshpass-1.05/ && echo "[*]		Configuring SSHPASS......" && ./configure >/dev/null
echo "[*]		Making......" && make >/dev/null && echo "[*]		Done......"
sleep 2
echo "[*]		Installing......" && make install >/dev/null && echo "[*]		Done......" && echo "[*]		Checking......"
sleep 2
	if [ ! -f "/usr/local/bin/sshpass" ]
	then
	echo "[*]		SSHPASS Install Failed......"
	echo "[*]		Try Visiting http://sourceforge.net/projects/sshpass To Manually Install......"
	exit
	else
echo "[*]		Good To Go: SSHPASS Installed......"
	fi
fi

#DONE SSHPASS

#MOVING/COPYING FILES!

#MOVING/COPYING ANY FILES NECESSARY ADD BELOW FOR ORGANIZATION SAKE...

#Copying airport command to bin

echo "[STEP 3]		Copying/Moving Files......"

#Set variable if airport is there

if [ -f "/usr/sbin/airport" ]
then
airexist=0
else
airexist=1
fi

#Done with var set

if [ airport = "1" ]
then
cd /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/
echo "[*]		Copying airport......"
cp airport /usr/sbin/airport 
echo "[*]		Done......"
else
echo "[*]							airport good to go"


fi

#Find airport Manually (NOT NEEDED UNLESS WANT TO IMPLEMENT IN LATER VERSIONS...THIS SHOULD NEVER BE A PROBLEM

#if [ aircho = "n" ] 
#then
#echo "
#"
#else
#echo -n "Specify The Location Of airport (Full Path!) : "
#read airloc
	#if [ -f $airloc ]
	#then
	#cd $airloc
	#echo "[*]		Copying airport......"
	#cp $airloc /usr/sbin/airport
	#echo "[*]		Done......"
	#else
	#echo "[*]		That's Not A Valid Location......"
	#fi
	#fi

#END FIND MANUALLY



#MOVING/COPYING ANY FILES NECESSARY ADD ABOVE THIS LINE FOR FOR ORGANIZATION SAKE...

#MOVING/COPYING FILES END




#THE CLEANUP SECTION#####


#DELETE ANY FILES OR GENERATED CRAP BELOW!
echo "[FINAL STEP!]		Cleaning Up......"
cd $HOME
echo "[*]		Cleaning SSHPASS......"
if [ -f $HOME/sshpass-1.05.tar.gz ]
then
rm sshpass-1.05.tar.gz && echo "[STEP 1]		Done......"
else
echo "[*]		Already Cleaned. Skipping......"
fi
if [ -d $HOME/sshpass-1.05/ ]
then
rm -r sshpass-1.05 && echo "[STEP 2]		Done......"
else
echo "[*]		Already Cleaned. Skipping......"
fi



#NO MORE CLEANUP!######


#ANY FILE THAT NEED TO BE MANUALLY CREATED GO HERE

#MAKE COBRA ERROR LOG FILE

echo "[STEP 4]		Checking For Log File......"
#Check To See If Log File Exists And Set Var
if [ -f "$HOME/cobra_errors.log" ]
then
logok=0
else
logok=1
fi
#Done
	if [ $logok = "1" ];
	then
	echo "[*]							no......"
	echo "[*]		Creating Log File......"
	cd $HOME
	touch cobra_errors.log
	chmod ugo=rwx cobra_errors.log
	chflags hidden cobra_errors.log
	echo "[*]		Log File Created Successfully......"
	else
	echo "[*]		Log File Already Exists......"
	echo "[*]		Skipping......"
	fi
#END MAKE COBRA LOG FILE







# END MANUAL CREATION















