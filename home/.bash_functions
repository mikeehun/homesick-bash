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
	function homesick-status-all() {
		while read hl; do
			repo=$(echo $hl | tr -s ' ' ' ' | cut -d\  -f1);
			homesick status $repo;
		done < <(homesick list )
	}
fi
