# Use the official Jenkins LTS image as the base image
FROM jenkins/jenkins:lts

# Switch to root user for installation
USER root

# install sudo
RUN apt-get update && apt-get install -y sudo
# add jenkins to sudoers
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Install Docker binaries
RUN curl -fsSL https://get.docker.com | sh
# add jenkins to docker group
RUN usermod -aG docker jenkins

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
# Switch back to the Jenkins user
USER jenkins

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]
