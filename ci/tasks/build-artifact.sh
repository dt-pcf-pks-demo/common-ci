#!/usr/bin/env sh
set -e
export ROOT_FOLDER=$( pwd )
export GRADLE_OPTS=-Dorg.gradle.native=false
GRADLE_HOME="${HOME}/.gradle"
GRADLE_CACHE="${ROOT_FOLDER}/gradle"
[[ -d "${GRADLE_CACHE}" && ! -d "${GRADLE_HOME}" ]] && ln -s "${GRADLE_CACHE}" "${GRADLE_HOME}"

M2_HOME=${HOME}/.m2
mkdir -p ${M2_HOME}
M2_LOCAL_REPO="${ROOT_FOLDER}/.m2"
mkdir -p "${M2_LOCAL_REPO}/repository"
 
cat > ${M2_HOME}/settings.xml <<EOF
 
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                          https://maven.apache.org/xsd/settings-1.0.0.xsd">
      <localRepository>${M2_LOCAL_REPO}/repository</localRepository>
</settings>
 
EOF


version=`cat version/number`
cd order-repo
echo $version
./mvnw clean package -Dmaven.test.skip=true
ls -la ./target/
mv ./target/microservice-kubernetes-demo-order-*.jar ../workspace/microservice-kubernetes-demo-order-$version.jar
ls -la ../workspace/


