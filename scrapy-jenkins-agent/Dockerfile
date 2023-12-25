FROM jenkins/agent:latest

USER root
# intend in multiple lines
RUN apt-get update && \
    apt-get install -y python3-scrapy

# Switch back to the jenkins user
USER jenkins