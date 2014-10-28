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

