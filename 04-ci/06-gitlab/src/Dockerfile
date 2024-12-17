FROM centos:7

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update -y

WORKDIR /opt
RUN yum install -y make gcc openssl-devel bzip2-devel libffi-devel zlib-devel
RUN curl -O https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
RUN tar -zxvf Python-3.8.12.tgz
RUN ./Python-3.8.12/configure --enable-shared
RUN make
RUN make install
RUN cp --no-clobber ./libpython3.8.so* /lib64/
RUN chmod 755 /lib64/libpython3.8.so*
RUN chmod -R 755 /usr/local/lib/python3.8
RUN rm -rf /opt/*

RUN pip3 install flask flask-jsonpify flask-restful
RUN mkdir -p /python_api
WORKDIR /python_api
COPY python-api.py ./
CMD ["python3", "-u", "python-api.py"]
