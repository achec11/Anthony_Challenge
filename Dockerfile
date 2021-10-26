FROM centos:7

RUN yum update -y
RUN yum install httpd mod_ssl -y

RUN openssl req -x509 -nodes -days 365 \
    -subj  "/C=US/ST=PA/O=Company Inc/CN=secnet.test.org" \
    -newkey rsa:2048 -keyout /etc/httpd/conf/server.key \
    -out /etc/httpd/conf/server.crt

RUN mkdir /var/www/secnet 

COPY index.html /var/www/html/
COPY ssl.conf /etc/httpd/conf.d/
COPY secnet.conf /etc/httpd/conf.d/
COPY index.html /var/www/secnet/

RUN httpd -t

EXPOSE 443

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]