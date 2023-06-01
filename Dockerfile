FROM tomcat:9
# Download the .war file from Nexus using wget and save as ROOT.war
RUN  wget -O /usr/local/tomcat/webapps/ROOT.war  http://admin:admin@175.41.216.133:8081/repository/studentapp-snap/http://3.145.9.227:8081/repository/student-snap/com/jdevs/studentapp/2.5-SNAPSHOT/maven-metadata.xml
EXPOSE 8080
CMD ["catalina.sh", "run"]
