pipeline {
  agent none
  stages {
    stage('Test Cookbooks') {
      parallel {
        stage('Test Bookstack') {
          steps {
            sh 'cd cookbooks/bookstack && kitchen test'
          }
        }

        stage('Test Build Slave') {
          steps {
            sh 'cd cookbooks/build_slave && kitchen test'
          }
        }

        stage('Test Common') {
          steps {
            sh 'cd cookbooks/common && kitchen test'
          }
        }

        stage('Test DB') {
          steps {
            sh 'cd cookbooks/db && kitchen test'
          }
        }

        stage('Test Grafana') {
          steps {
            sh 'cd cookbooks/grafana && kitchen test'
          }
        }

        stage('Test Jenkins') {
          steps {
            sh 'cd cookbooks/jenkins && kitchen test'
          }
        }

        stage('Test Nginx') {
          steps {
            sh 'cd cookbooks/nginx && kitchen test'
          }
        }

        stage('Test Prometheus') {
          steps {
            sh 'cd cookbooks/prometheus && kitchen test'
          }
        }
      }
    }
  }
}
