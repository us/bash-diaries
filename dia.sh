#!/bin/sh
check_files(){
	FILE=./.git
	PSS=./.pss.zip
	DAYBOOK=./.daybook
	
	if [ -e "$FILE" ]; then
	    echo "GIT File found!";	  
	else
		git init;
	fi
	#DAYBOOK=./daybook
	if [ -e "$PSS" ]; then
	    echo "PSS File found!";	  
	else
		touch .pss
		dialog --title "Password" \
		--clear \
		--insecure \
		--passwordbox "1 - Please create password" 10 30 2> .pss

		zip -P $(cat .pss) .pss.zip .pss
		rm -f .pss;
	fi
	if [ -e "$DAYBOOK" ]; then
	    echo "DAYBOOK File found!";	  
	else
		mkdir $DAYBOOK;
		#zip -P $(cat $PSS) daybook.zip $DAYBOOK
	fi
}

create_tempfile(){
	touch .tempfile
	tempfile=.tempfile
}

take_password(){
	dialog --title "Password" \
		--clear \
		--insecure \
		--passwordbox "2 - Enter your password" 10 30 2> $tempfile
}

check_password(){
	take_password
		unzip -P $(cat $tempfile) .pss.zip || check_password
		rm $tempfile
	#return $true
}

choose_date(){
	da=$(dialog --stdout --title "My Calendar" \
	                   --calendar "Select a date:" 0 0  $(date -d +%d) $(date -d +%m) $(date -d +%Y))
	[[ $da =~ (..)/(..)/(....) ]]
	year=${BASH_REMATCH[3]}
	month=${BASH_REMATCH[2]}
	day=${BASH_REMATCH[1]}
	dat="$day-$month-$year"

	}

access_daybook(){
	unzip -P $(cat .pss) .daybook.zip 
	rm -f .daybook.zip
}


finally(){
	zip -P $(cat .pss) -r .daybook.zip $DAYBOOK
	rm -rf  .pss $DAYBOOK
}

main(){
	check_files
	create_tempfile
	check_password
	choose_date

	if [ "$1" != "" ]; then
		FILENAME="$dat-$1";
	else
		FILENAME="$dat";
	fi
	

	access_daybook
	case $? in
	0)
	 #echo "You have entered: $1-$dat"
	 #echo "your password is $pas tempfile is $(cat $tempfile)"

	 # check the editor (default nano)

	 if [ -n "$EDITOR" ]; then 
		 $EDITOR .daybook/"$FILENAME"
	 else 
	 	nano .daybook/"$FILENAME"
	 fi
	 #$(date +%d)-$(date +%m)-$(date +%Y)
	 ;;
	1)
	 echo "You have pressed Cancel"  ;;
	255)
	 echo "Box closed"   ;;
	esac

	#rm -rf $DAYBOOK

}
main "$@"
	finally
