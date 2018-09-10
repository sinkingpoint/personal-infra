pipeline {
  agent none
  stages {
    stage('Test Cookbooks') {
      parallel {
        stage('Test Bookstack') {
          sh 'cd cookbooks/bookstack && kitchen test'
        }

        stage('Test Build Slave') {
          sh 'cd cookbooks/build_slave && kitchen test'
        }

        stage('Test Common') {
          sh 'cd cookbooks/common && kitchen test'
        }

        stage('Test DB') {
          sh 'cd cookbooks/db && kitchen test'
        }

        stage('Test Grafana') {
          sh 'cd cookbooks/grafana && kitchen test'
        }

        stage('Test Jenkins') {
          sh 'cd cookbooks/jenkins && kitchen test'
        }

        stage('Test Nginx') {
          sh 'cd cookbooks/nginx && kitchen test'
        }

        stage('Test Prometheus') {
          sh 'cd cookbooks/prometheus && kitchen test'
        }
      }
    }
  }
}
