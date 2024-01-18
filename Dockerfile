# define base docker image
FROM openjdk:17
EXPOSE 8080
ADD target/springbootWelcomeProject.jar springbootWelcomeProject.jar
ENTRYPOINT [ "java", "-jar","/springbootWelcomeProject.jar" ]