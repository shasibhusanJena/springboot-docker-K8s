# springboot-docker-K8s
 
## this project describes how to create and deploy a Springboot application in Kubernate cluster

### Install of Docker and Kubernate on windows

    - download Desktop Installer.exe and then follow link 
    https://docs.docker.com/desktop/install/windows-install/

    once installation is complete then setting --> Kubernates --> Enable Kubernate checkbox --> Apply and restart

### Create Image on in Docker

    in the springboot application to create an image first step is to create a file Dockerfile and add below code into it.
        FROM openjdk:17
        EXPOSE 8080
        ADD target/springbootWelcomeProject.jar springbootWelcomeProject.jar
        ENTRYPOINT [ "java", "-jar","/springbootWelcomeProject.jar" ]

    Next is to build our project into Kubernetes cluster
    go to the project root directory and then buid the project , and provide image name and version
        - > docker build -t projectwelcome:1.0 .

### Deploy application on Kubernate

    similarly install minikube on windows and once installtion is complete, we want docker to be executed inside minicube. 
    - minikube
    - Kubectl
    below command is to run the docker image inside Kubernate.
    - minikube start --driver=docker
    Next create Kubernetes service object and deployment object so that we can access it from outer world.
    here we are providing the deployment obj name and the port NO
    - kubectl create deployment springbootwelcome-deployment --image=projectwelcome:1.0 --port=8080
    - kubectl get deployment
    
    to get more info about deployment do describe method
    - Kubectl describe deployment springbootwelcome-deployment
    
    to get pod details on which springboot application is up from the deployment
    - kubectl get pods
    to check the logs of the application
    - kubectl logs springbootwelcome-deployment-985968694-hf5gx

    Next we need to create a service so that it can be accessed outside of the world
    -   kubectl get service
    -   kubectl expose deployment springbootwelcome-deployment --type=NodePort
    service/springbootwelcome-deployment exposed
    -   kubectl get service
    -   minikube service springbootwelcome-deployment --url
        http://127.0.0.1:64668

        http://127.0.0.1:64668/welcome
        Gives us response back by running above URL on web
### Clean up process in Docker
    to remove existing docer image , here a7daf591c0dd is image id
        - docker image rm a7daf591c0dd

### Cleanup Process on Kubernate

    Delete existing deployment in the kubectl cluster.

    - kubectl delete deployment --all --all-namespaces=true