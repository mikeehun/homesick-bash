#!/bin/bash

function whatismyip() {
    curl ipv4.icanhazip.com
}

function pdfman() {
	if [ ! -r /tmp/pdfman-$1.pdf ]; then
		man -t $1 | ps2pdf - /tmp/pdfman-$1.pdf
	fi
	evince /tmp/pdfman-$1.pdf
}
complete -F _man pdfman

function killprocname(){
	procs=`ps -ef | grep -i "$1" | grep -v grep | tr -s " " " " | cut -d\  -f 2`

	oldIFS=IFS
	IFS=\
	countProcs=`echo $procs | wc -l`
	IFS=$oldIFS

	if [ ${countProcs} -gt 1 ]
	then
		echo "Not unique selection..." &> /dev/stderr
		return
	elif [ "$(echo $procs)X" == "X" ]
	then
		echo "No such process..."
		return
	fi
	echo "kill: ${procs}"
	kill -9 ${procs}
}

function grepkill(){
	if [ $# -eq 1 ]; then
		killargs="-9"
		filter=$1
	elif [ $# -eq 2 ]; then
		killargs=$1
		filter=$2
	fi
	procs=`ps -ef | grep -i "$filter" | grep -v grep | tr -s " " " " | cut -d\  -f 2`
	if [ ! -z ${procs} ]; then
		kill ${killargs} ${procs}
	else
		echo "no processes found";
	fi
}

if command -v mvn >/dev/null 2>&1; then
	function mvn-rdebug-test() {
		mvn clean test -Dmaven.surefire.debug="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8002 -Xnoagent -Djava.compiler=NONE" -Dcobertura.skip=true -Dfindbugs.skip=true -Dcheckstyle.skip=true -DfailIfNoTests=false -Dtest=$1 -o
	}

	function mvn-go-up() {
		while ! ls pom.xml >/dev/null 2>&1; do
			[ "$(pwd)" == ~ ] && break;
			cd ..
		done
	}
fi

function cd-switch() {
    cd $(pwd | sed "s#/$1/#/$2/#g")
}

function load-scripts() {
    if [ -d ~/install/_scripts -a -d ~/bin ]; then
        cd ~/install/_scripts
        for f in $(\ls -1); do
            linkName=$(echo $f | rev | cut -d\. -f2- | rev)
            rm -f ~/bin/$linkName 2>/dev/null
            if [ -x $f ]; then
                ln -sf ~/install/_scripts/$f ~/bin/$linkName
            fi
        done
        cd - >/dev/null 2>&1
    fi
}

function unload-scripts() {
    if [ -d ~/install/_scripts -a -d ~/bin ]; then
        cd ~/install/_scripts
        for f in $(\ls -1); do
            linkName=$(echo $f | rev | cut -d\. -f2- | rev)
            rm -f ~/bin/$linkName 2>/dev/null
        done
        cd - >/dev/null 2>&1
    fi
}

if command -v homesick >/dev/null 2>&1; then
	function homesick-all() {
		[ $# -ne 1 ] && homesick && return 1;
		[ $(homesick | tr -s ' ' ' ' | grep -B1000 "options:" | cut -d\  -f 3 | egrep "^[a-zA-Z]+$" | egrep -c "^${1}$") -ne 1 ] && echo "Invalid command" && return 2;
		while read hl; do
			repo=$(echo $hl | tr -s ' ' ' ' | cut -d\  -f1);
			#echo -e "\e[31m--= ${repo} =--\e[39m"
			echo -e "\e[43m--= ${repo} =--\e[39m\e[49m"
			homesick $1 $repo;
			echo
		done < <(homesick list )
	}
fi

function free-swap() {
	free_data="$(free)"
	mem_data="$(echo "$free_data" | grep 'Mem:')"
	free_mem="$(echo "$mem_data" | awk '{print $4}')"
	buffers="$(echo "$mem_data" | awk '{print $6}')"
	cache="$(echo "$mem_data" | awk '{print $7}')"
	total_free=$((free_mem + buffers + cache))
	used_swap="$(echo "$free_data" | grep 'Swap:' | awk '{print $3}')"

	echo -e "Free memory:\t$total_free kB ($((total_free / 1024)) MB)\nUsed swap:\t$used_swap kB ($((used_swap / 1024)) MB)"
	if [[ $used_swap -eq 0 ]]; then
		echo "Congratulations! No swap is in use."
	elif [[ $used_swap -lt $total_free ]]; then
		echo "Freeing swap..."
		sudo swapoff -a
		sudo swapon -a
	else
		echo "Not enough free memory. Exiting."
		exit 1
	fi
}

