
                        FROM openjdk:11-jre-slim
                        ARG artifact=java-maven-sonar-argocd-helm-k8s/spring-boot-app/target/spring-boot-web.jar
                        WORKDIR /opt/app
                        COPY ${artifact} app.jar
                        ENTRYPOINT ["java", "-jar", "app.jar"]
                    