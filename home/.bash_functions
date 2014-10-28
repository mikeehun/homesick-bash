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

