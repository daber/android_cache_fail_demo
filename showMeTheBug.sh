#!/usr/bin/env bash
exe() { echo "\$ $@" ; "$@" ; }
PURPLE="\u001B[35m"
RED="\u001B[31m"
RST="\u001B[0m"
GRADLE="./gradlew -q --console=plain -Dorg.gradle.daemon=false"

printf "$PURPLE cleaning eventual build leftovers \n $RST"
exe rm -fr ap1/app/build
exe rm -fr ap2/app/build

printf "$PURPLE Builds and tests app \n
 This file also generates cachable file  /ap1/app/build/intermediates/unit_test_config_directory/debugUnitTest/out/com/android/tools/test_config.properties\n
 This file lands in the global gradle cache and it contails project specific paths.\n $RST"

pushd ./ap1
exe $GRADLE test showMeTheBug
printf "$PURPLE ap1 builds For this project everyting is fine gradle cache is already corrupted\n $RST"
popd

pushd ./ap2
printf "$PURPLE ap2 will build from cache as it's inputs are identical\nBut check the paths of test resources \n $RST"
exe $GRADLE test showMeTheBug
popd
printf "$PURPLE Now deleting outpus of both project and running only ap2 guess what will happen ;P\n$RST"
exe rm -fr ap1/app/build
exe rm -fr ap2/app/build
pushd ./ap2
exe $GRADLE test showMeTheBug
popd
printf " Tasks to blame are $RED  generateReleaseUnitTestConfig generateDebugUnitTestConfig\n$RST Generaly $RED com.android.build.gradle.tasks.GenerateTestConfig $RST \n"
