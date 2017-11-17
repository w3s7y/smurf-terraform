#!/bin/bash

su -l -c 'cd ~admin; nohup /usr/lib/jvm/java-8-openjdk-amd64/bin/java -jar /home/admin/.jenkins/jobs/Build SR/builds/lastSuccessfulBuild/archive/smurfweb/target/smurfweb-0.0.1-SNAPSHOT.war &'
