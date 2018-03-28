node {
    environment {
        KUBECONFIG='/var/kube'
    }
  def project = 'robo-rabbit'
  def appName = 'caporderack'
  def feSvcName = "caporderack-svc"
  def imageTag = "sabbour/captureorderack-netcore"
  def teamName = "ROBO-CLUSTERS"


  //-----Dev Env Vars----//
  def devMongoKey = "mongodb://robo-dev-cosmos-db:qLL3oTfiz9vrv8LbyD6Rld1kmDUbMwkSdhfVQgZXsTmQ9OmRXrhKHmADGpujz6sfUyVkMuJP9PoltOTNFb2bQQ==@robo-dev-cosmos-db.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  def devEventPol = "Ea6RMUMhTXF00gF5cmasQUzYTlVNu//zK8F9dSIt8Hw="
  def devAMPQURL = "amqps://RootManageSharedAccessKey:Ea6RMUMhTXF00gF5cmasQUzYTlVNu%2F%2FzK8F9dSIt8Hw%3D@robo-dev-event-hub.servicebus.windows.net/robo-dev-event-hub"
  
  //-----Prod Env Vars----//
  def prodMongoKey = "mongodb://robo-cosmos-db:EnEPexfG6ONZP4x2NvNimhGX3NQy1zuPid7kCPiKn6KkS1gXx3p5rErNgrlyvTXbLLfLdpENFAWd856pFxlEqg==@robo-cosmos-db.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  def prodEventPol = "rPNjMS4vqhL0OZ3SrpIsL0Z8CZ67cIdxQM9Ig4GkRdE="
  def prodAMPQURL = "amqps://RootManageSharedAccessKey:Ea6RMUMhTXF00gF5cmasQUzYTlVNu%2F%2FzK8F9dSIt8Hw%3D@robo-dev-event-hub.servicebus.windows.net/robo-dev-event-hub"
  
  checkout scm

  stage "Deploy Application"
  
  sh("sed -i.bak 's#DOCKER-IMAGE#${imageTag}#' ./k8s/*.yaml")
  sh("sed -i.bak 's#APP-NAME#${appName}#' ./k8s/*.yaml")
  sh("sed -i.bak 's#SVC-NAME#${feSvcName}#' ./k8s/*.yaml")
  sh("sed -i.bak 's#NAME-SPACE#${env.BRANCH_NAME}#' ./k8s/*.yaml")
  sh("sed -i.bak 's#TEAM-NAME#${teamName}#' ./k8s/*.yaml")

  switch (env.BRANCH_NAME) {
  // Roll out to dev
    case "robo-dev":
        // Change deployed image in canary to the one we just built
        sh("sed -i.bak 's#MONGO-KEY#${devMongoKey}#' ./k8s/*.yaml")
        sh("sed -i.bak 's#EVENT-POLICY#${devEventPol}#' ./k8s/*.yaml")
        sh("sed -i.bak 's#AMQP-URL#${devAMPQURL}#' ./k8s/*.yaml")
        sh("kubectl --namespace=robo-dev apply -f k8s/")
            break
    // Roll out to production
    case "robo-prod":
        // Change deployed image in canary to the one we just built
        sh("sed -i.bak 's#MONGO-KEY#${prodMongoKey}#' ./k8s/*.yaml")
        sh("sed -i.bak 's#EVENT-POLICY#${prodEventPol}#' ./k8s/*.yaml")
        sh("sed -i.bak 's#AMQP-URL#${prodAMPQURL}#' ./k8s/*.yaml")
        sh("kubectl --namespace=robo-prod apply -f k8s/")
            break
    // Roll out a dev environment
    default:
        echo 'Hi Francis!'
  }
}


