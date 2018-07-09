export JAVA_HOME=$(readlink -e $(type -p javac) | sed  -e 's/\/bin\/javac//g')
export PATH="${PATH}:${JAVA_HOME}/bin"
