# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias grep='grep --color=auto'
alias tree='tree -C'
alias ls='ls --group-directories-first --color=always -hF'
alias l='ls'
alias robot-pre="TZ=GMT MAVEN_OPTS=\"-Xms2048M  -Xmx2048M -XX:MaxPermSize=2048m -Dfile.encoding=utf-8 -Denvironment=hudson -javaagent:/home/kalantziss/.m2/repository/org/springframework/spring-instrument/3.0.3.RELEASE/spring-instrument-3.0.3.RELEASE.jar\" mvn pre-integration-test"
alias robot-cargo="TZ=GMT MAVEN_OPTS=\"-Xms2048M -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -Xmx2048M -XX:MaxPermSize=2048m -Dfile.encoding=utf-8 -Denvironment=hudson -javaagent:/home/kalantziss/.m2/repository/org/springframework/spring-instrument/3.0.3.RELEASE/spring-instrument-3.0.3.RELEASE.jar\"  mvn org.codehaus.cargo:cargo-maven2-plugin:start"
alias robot-cargo-dcevm="JAVA_HOME=~/.IntelliJIdea13/config/plugins/DCEVM_JRE TZ=GMT MAVEN_OPTS=\"-Xms2048M -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -Xmx2048M -XX:MaxPermSize=2048m -Dfile.encoding=utf-8 -Denvironment=hudson -javaagent:/home/kalantziss/.m2/repository/org/springframework/spring-instrument/3.0.3.RELEASE/spring-instrument-3.0.3.RELEASE.jar\"  mvn org.codehaus.cargo:cargo-maven2-plugin:start"
alias robot-run="TZ=GMT mvn com.googlecode.robotframework-maven-plugin:robotframework-maven-plugin:run"
alias robot-results="google-chrome target/robotframework/log.html"
alias mvn-cargo="TZ=GMT MAVEN_OPTS=\"-Xms2048M -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -Xmx2048M -XX:MaxPermSize=2048m -Dfile.encoding=utf-8 -Denvironment=hudson\"  mvn clean install -DskipTests -Pcargo"
alias calcu='gcalctool'
alias mongoose='python -m SimpleHTTPServer 9098'
alias mtail='multitail --config ~/.multitail.conf -n 102400 -m 0 -mb 100MB'
alias mvntail='mtail -cS maven'
alias xclip='xclip -selection clipboard'
alias cpath='pwd | tr -d "\n" | xclip'
alias cdpath='cd "$(xclip -o)"'
alias cdmvn='cdpath; mvn-go-up'

function PS_GUAKE() {
	if ! $(gconftool-2 --get /apps/guake/general/use_vte_titles); then
		if [ $(echo $STY | grep -c guake) -eq 1 ]; then
			guake -r "$(whoami)@$(hostname -s)$(pwd)" >/dev/null 2>&1 &
		fi
	fi
}

function mvn-rdebug-test() {
	mvn clean test -Dmaven.surefire.debug="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8002 -Xnoagent -Djava.compiler=NONE" -Dcobertura.skip=true -Dfindbugs.skip=true -Dcheckstyle.skip=true -DfailIfNoTests=false -Dtest=$1 -o
}

function mvn-go-up() {
	while ! ls pom.xml >/dev/null 2>&1; do
		[ "$(pwd)" == ~ ] && break;
		cd ..
	done
}

function change() {
	cd $(pwd | sed "s#/$1/#/$2/#g")
}

export HISTCONTROL=erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTIGNORE="&:cd:ls:exit:logout:top:pwd:clear:uptime"
export PROMPT_COMMAND="history -a;\$(PS_GUAKE)"

export -f mvn-go-up
export -f mvn-rdebug-test

shopt -s checkwinsize
shopt -s globstar
shopt -s expand_aliases

PS1="\n\[\033[1;37m\]\342\224\214[\!]\
 $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;35m\]\u\[\033[00;35m\]@\h'; fi)\[\033[1;37m\] \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]V\"; else echo \"\[\033[01;31m\]X\"; fi)\[\033[1;37m\] \[\033[1;34m\]\w\[\033[1;37m\]\[\033[1;37m\]\n\342\224\224\342\224\200 \$ \[\033[0m\]"

while read f; do
	. "$f"
done < <(find ~/.bash_completion.d/ -type f -name "*completion*.*sh")

