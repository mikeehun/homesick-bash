#!/bin/bash

# User specific aliases and functions
alias tree='tree -C'
alias l='ls'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias vim='vim -p'
alias calcu='gcalctool'
alias mongoose='python -m SimpleHTTPServer 9098'
alias mtail='multitail --config ~/.multitail.conf -n 102400 -m 0 -mb 100MB'
alias xclip='xclip -selection clipboard'
alias cpath='pwd | tr -d "\n" | xclip'
alias cdpath='cd "$(xclip -o)"'
alias compass-init="compass init --syntax=sass --css-dir=css --javascripts-dir=js --sass-dir=sass --images-dir=images"

# color_prompt is set from ~/.bashrc
if [ "$color_prompt" == "yes" ]; then
	alias ls='ls -hF --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias less='less -R'
fi

# don't define these if there's no maven
if command -v mvn >/dev/null 2>&1; then
	alias robot-pre="TZ=GMT MAVEN_OPTS=\"-Xms512M -Xmx1536M -XX:PermSize=256M -XX:MaxPermSize=1536m -Dfile.encoding=utf-8 -Denvironment=hudson -javaagent:/home/kalantziss/.m2/repository/org/springframework/spring-instrument/3.0.3.RELEASE/spring-instrument-3.0.3.RELEASE.jar\" mvn pre-integration-test"
	alias robot-cargo="TZ=GMT MAVEN_OPTS=\"-Xms512M -Xmx1536M -XX:PermSize=256M -XX:MaxPermSize=1536m -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -Dfile.encoding=utf-8 -Denvironment=hudson -javaagent:/home/kalantziss/.m2/repository/org/springframework/spring-instrument/3.0.3.RELEASE/spring-instrument-3.0.3.RELEASE.jar\"  mvn org.codehaus.cargo:cargo-maven2-plugin:start"
	alias robot-cargo-dcevm="JAVA_HOME=~/.IntelliJIdea13/config/plugins/DCEVM_JRE TZ=GMT MAVEN_OPTS=\"-Xms2048M -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -Xmx2048M -XX:MaxPermSize=2048m -Dfile.encoding=utf-8 -Denvironment=hudson -javaagent:/home/kalantziss/.m2/repository/org/springframework/spring-instrument/3.0.3.RELEASE/spring-instrument-3.0.3.RELEASE.jar\"  mvn org.codehaus.cargo:cargo-maven2-plugin:start"
	alias robot-run="TZ=GMT mvn com.googlecode.robotframework-maven-plugin:robotframework-maven-plugin:run"
	alias robot-results="google-chrome target/robotframework/log.html"
	alias mvn-dirty="mvn -Dcobertura.skip=true -Dfindbugs.skip=true -Dcheckstyle.skip=true -DfailIfNoTests=false"
	alias mvn-dirty-install="mvn-dirty -DskipTests -Dmaven.test.skip=true clean install"
	alias mvntail='mtail -cS maven'
	alias cdmvn='cdpath; mvn-go-up'
fi
