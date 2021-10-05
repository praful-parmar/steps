# FROM maven:alpine as jaar
# COPY simple-java-maven-app /app
 
# WORKDIR /app
# RUN chmod 777 /usr/local/bin/mvn-entrypoint.sh
# ENTRYPOINT mvn test
# CMD mvn -B -DskipTests clean package

# CMD mvn -B -DskipTests clean package


FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=jaar  /app/target ./app
CMD java -jar /app/*.jar

