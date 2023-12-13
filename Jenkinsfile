pipeline {
    agent {
        docker {
            image 'tcsizmadia/scrapy-docker-agent'
        }
    }
    
    parameters {
        booleanParam(name: 'DRY_RUN', defaultValue: false, description: 'No scraping will happen')
        booleanParam(name: 'SLACK_SEND', defaultValue: false, description: 'Send notification to Slack')
    }
    
    stages {
        stage('Scrape Website') {
            steps {
                script {
                    if (params.DRY_RUN) {
                        echo 'Dry run, no scraping will happen'
                    } else {
                        sh 'scrapy crawl sandbox_spider -o sandbox.json'
                    }
                }
            }
        }
        
        stage('Archive') {
            when {
                expression {
                    currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                // Archive the scraped data
                archiveArtifacts artifacts: 'sandbox.json', fingerprint: true
            }
        }
        
        stage('Notify') {
            when {
                expression {
                    currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    if (params.SLACK_SEND) {
                        // Send notification to Slack
                        slackSend channel: '#sandbox', color: 'good', message: 'Scraping completed!'
                    }
                }
            }
        }
    }
}
