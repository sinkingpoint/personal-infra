pipeline {
  agent none
  stages {
    stage('Test Cookbooks') {
      def subfolders = sh(returnStdout: true, script: 'ls -d cookbooks/*').trim().split(System.getProperty("line.separator"))
      parallel {
        for(String folder : subfolders){
          stage('Testing ' + folder) {
            sh('echo Testing ' + folder)
          }
        }
      }
    }
  }
}
