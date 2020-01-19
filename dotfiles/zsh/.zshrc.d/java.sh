#export JAVA_HOME=$(readlink -e $(type -p javac) | sed  -e 's/\/bin\/javac//g')
#export JRE_HOME=$JAVA_HOME/jre
#export PATH="${PATH}:${JAVA_HOME}/bin"
export JAVA_HOME="/usr/lib/jvm/java-1.11.0-openjdk-amd64/"
