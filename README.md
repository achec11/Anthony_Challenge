For this challenge I chose to setup the web server as a Docker container running within Fargate.  In this repo I've included the Dockerfile for building out the container as well as a cloudformatino template for building out the infrastructure needed to run this container and two Ansible scripts for building the container and deploying the infrastructure.

- Dockerfile has been configured to update the OS with latest patches, install apache and mod_ssl, create a self signed certificate, copy Apache configurations, perform a lint test using httpd -t.  I chose to run the lint step here so that if there's a failure here the build itself will fail and nothing will be pushed to the registry.  

- ssl.conf has been configured to use the self signed certificate created in the container via the Dockerfile and has also been configured to disable SSLv2, SSLv3 and TLS 1 as well as disabling weak ciphers.

- secnet.conf is a virtual host configuration that is only listening on port 443 and has configurations to enable SSL.

- build-ansible.yml is an ansible script for building the container.  

- cluster.yml is a cloudformation template that builds out the cluster, service and task definition along with a load balancer that would sit in front of the container.  

- cluster-ansible.yml is an ansible script for running the cluster.yml cloudformation template.

In an ideal scenario I would have incorporated this into a CI/CD pipeline where I could have used a version number sourced from something like a package.json or pom.xml and tag the container with a version and/or a git commit sha.  I then could have used the sha and/or version number when specifying a version of the container to deploy as opposed to simply using the latest tag.  
