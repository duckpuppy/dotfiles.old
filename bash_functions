# Weather by us zip code - Can be called two ways # weather 50315 # weather "Des Moines" 
weather () 
{ 
	declare -a WEATHERARRAY 
	WEATHERARRAY=( `lynx -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for" | grep -v "Add to "`) 
	echo ${WEATHERARRAY[@]} 
}

#extract - extract most common compression types 
extract () { 
     if [ -f $1 ] ; then 
         case $1 in 
             *.tar.bz2)   tar xjf $1        ;; 
             *.tar.gz)    tar xzf $1     ;; 
             *.bz2)       bunzip2 $1       ;; 
             *.rar)       rar x $1     ;; 
             *.gz)        gunzip $1     ;; 
             *.tar)       tar xf $1        ;; 
             *.tbz2)      tar xjf $1      ;; 
             *.tgz)       tar xzf $1       ;; 
             *.zip)       unzip $1     ;; 
             *.Z)         uncompress $1  ;; 
             *.7z)        7z x $1    ;; 
             *)           echo "'$1' cannot be extracted via extract()" ;; 
         esac 
     else 
         echo "'$1' is not a valid file" 
     fi 
}

#myip - finds your current IP if your connected to the internet 
myip () 
{ 
lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' 
} 

#clock - A bash clock that can run in your terminal window. 
clock () 
{ 
while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done 
} 

#netinfo - shows network information for your system 
netinfo () 
{ 
echo "--------------- Network Information ---------------" 
/sbin/ifconfig | awk /'inet addr/ {print $2}' 
/sbin/ifconfig | awk /'Bcast/ {print $3}' 
/sbin/ifconfig | awk /'inet addr/ {print $4}' 
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}' 
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' ` 
echo "${myip}" 
echo "---------------------------------------------------" 
} 

#shot - takes a screenshot of your current window 
shot () 
{ 
import -frame -strip -quality 75 "$HOME/$(date +%s).png" 
}

# Define a word - USAGE: define dog 
define () 
{ 
lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*"  | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt 
         if [[ -s  /tmp/templookup.txt ]] ;then    
            until ! read response 
               do 
               echo "${response}" 
               done < /tmp/templookup.txt 
            else 
               echo "Sorry $USER, I can't find the term \"${1} \""             
         fi    
rm -f /tmp/templookup.txt 
}

