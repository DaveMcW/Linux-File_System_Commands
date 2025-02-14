#!/bin/bash
# touch test
. ~/workspace/.guides/bashtests/function.sh

bash_history=~/.bash_history
BASHDIR=/home/codio/workspace/.guides
check_file=cli-2-2
hist_file="$BASHDIR/bashtests/$check_file.txt"

echo "$check_file" >> $bash_history
grep -A2000 -e "^$check_file" $bash_history > "$BASHDIR/bashtests/${check_file}.txt"
find "$hist_file" -type f -exec sed -i "s@~@$HOME@g" {} \; 

# Must match for erasing history
RES_HIST=0
COUNT=0
QCOUNT=3


function test_command {
	(( COUNT ++ ))
	if [[ $COUNT -le $QCOUNT ]]; then
		case $COUNT in
			1 )
				expect_files "/home/codio/workspace/test-website/index.html" "/home/codio/workspace/test-website/.website-config" "/home/codio/workspace/test-website/css/styles.css" "/home/codio/workspace/test-website/img/logo.png" "/home/codio/workspace/test-website/js/scripts.js"
				;;
			2 )
				expect_commands "list test-website/css directory from ~/workspace folder, including hidden files" "ls -a test-website/css" "ls -al test-website/css/" "ls -la test-website/css/" "ls -a ~/workspace/test-website/css/" "ls -al ~/workspace/test-website/css" "ls -la ~/workspace/test-website/css"
				;;
            3 )
				expect_command "clear" "clear terminal screen"
				;;
		esac
	else 
echo "Well done!"
return 0
	fi
}


test_command
