pipeline {
    agent any
    
    parameters {
        booleanParam(name: 'DRY_RUN', defaultValue: false, description: 'No scraping will happen')
        booleanParam(name: 'SLACK_SEND', defaultValue: false, description: 'Send notification to Slack')
    }
    
    stages {
        if (params.DRY_RUN) {
            stage('Dry Run') {
                steps {
                    echo 'Dry run mode enabled, no scraping will happen!'
                }
            }
        } else {
            stage('Scrape Website') {
                steps {
                    // Execute scrapy spider
                    sh 'scrapy crawl sandbox_spider -o sandbox.json'
                }
            }
            
            stage('Archive') {
                steps {
                    // Archive the scraped data
                    archiveArtifacts artifacts: 'sandbox.json', fingerprint: true
                }
            }
            
            stage('Notify') {
                steps {
                    if (params.SLACK_SEND) {
                        // Send notification to Slack
                        slackSend channel: '#sandbox', color: 'good', message: 'Scraping completed!'
                    }
                }
            }
        }
    }
}
