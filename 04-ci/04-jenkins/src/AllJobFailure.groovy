pipeline {
    agent {
        label 'linux' 
    }
    stages {
        stage('status') {
            steps {
                script {
                    String JSON = ''
                    Jenkins.instance.getAllItems(Job.class).each { job_item ->
                        def job_builds = jenkins.model.Jenkins.instance.getItemByFullName(job_item.getFullName()).builds
                        for (job_build in job_builds) {
                            if (job_build.result.toString() == 'FAILURE') {
                                 JSON += '{"job_name": "' + job_item.getFullName() + '", "job_number": "' + job_build.toString().minus(job_item.getFullName() + ' #') + '", "job_status": "' + job_build.result + '"}, '
                                 break
                            }
                        }
                    }
                    println '[' + JSON.substring(0, JSON.length() - 2) + ']'
                }
            }    
        }
    }
}
