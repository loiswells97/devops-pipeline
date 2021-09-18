# This is the script corresponding to the Jenkins job BuildAndTestWellbeingPortal
# which is triggered by pushes to the master branch in GitLab.

mysql -u root -p'<PASSWORD>' < SSOSS_CircusSkill.sql

which java

export JAVA_HOME=/usr
export PATH=$PATH:$JAVA_HOME/bin/java

which java

/opt/gradle/gradle-6.7.1/bin/gradle clean
/opt/gradle/gradle-6.7.1/bin/gradle build
/opt/gradle/gradle-6.7.1/bin/gradle test

/opt/gradle/gradle-6.7.1/bin/gradle jacocoTestReport
