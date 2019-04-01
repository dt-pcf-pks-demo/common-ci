#!/usr/bin/env sh
set -e
export ROOT_FOLDER=$( pwd )
export GRADLE_OPTS=-Dorg.gradle.native=false

GRADLE_HOME="${HOME}/.gradle"
GRADLE_CACHE="${ROOT_FOLDER}/gradle"

[[ -d "${GRADLE_CACHE}" && ! -d "${GRADLE_HOME}" ]] && ln -s "${GRADLE_CACHE}" "${GRADLE_HOME}"

export GRADLE_OPTS=-Dorg.gradle.native=false
cd music-repo
./gradlew -v
./gradlew test --no-daemon
