pipeline {
    agent {
        docker { image 'tcsizmadia/scrapy-jenkins-agent' }
    }
    
    parameters {
        booleanParam(name: 'DRY_RUN', defaultValue: false, description: 'No scraping will happen')
        booleanParam(name: 'SLACK_SEND', defaultValue: false, description: 'Send notification to Slack')
    }
    
    stages {
        tage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    doGenerateSubmoduleConfigurations: false, 
                    extensions: [], 
                    submoduleCfg: [], 
                    userRemoteConfigs: [[url: 'git@github.com:tcsizmadia/iphone-price-scraper.git']]
                ])
            }
        }
        stage('Pre-Flight') {
            steps {
                // Check Python version
                sh 'python3 --version'
                // Check Scrapy version
                sh 'scrapy version'
            }
        }
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
