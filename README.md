# Sample Code for Using Scrapy and Jenkins for Webscraping

This repository contains sample code and miscelaneous material for the blog post 'Scraping the web with Scrapy and Jenkins' on [2ndworst.dev](https://2ndworst.dev).

## Contents

- [Setup](#setup)
- [Usage](#usage)
- [License](#license)

## Setup

Make sure you have a working Docker installation on your machine.
To get started, build the `scrapy-jenkins-agent` Docker image:

```bash
docker compose build scrapy-jenkins-agent
```

Create a `jenkins_home` directory to persist the Jenkins data:

```bash
mkdir jenkins_home
```

Start the Jenkins server:

```bash
docker compose up -d jenkins
```

Open a browser and navigate to [http://localhost:8080](http://localhost:8081). Follow the instructions to complete the Jenkins setup.
For the initial setup, you will need to retrieve the initial admin password from the Jenkins container:

```bash
docker exec scrapy-sandbox-jenkins-1 cat /var/jenkins_home/secrets/initialAdminPassword
```

(You can check the name of the Jenkins container with `docker ps`.)

To make this setup work, you will need to install the Docker and Docker Pipeline plugins. You can do this from the Jenkins UI.

Finally, create a new Jenkins pipeline job and point it to the `Jenkinsfile` in this repository.

## License

This project is licensed under the [MIT License](LICENSE).
