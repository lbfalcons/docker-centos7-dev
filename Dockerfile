FROM centos:8.4.2105
LABEL version="0.1"
LABEL description="a centos8 based docker image for c++ development"
LABEL maintainer="lb"

#RUN yum clean all && \
#    yum -y install epel-release && \
#    yum -y install centos-release-scl && \
#    yum -y clean all

#RUN yum-config-manager --enable rhel-server-rhscl-7-rpms

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV TERM=xterm-256color

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
# snappy-devel
RUN sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/CentOS-Linux-PowerTools.repo


WORKDIR /tmp
COPY install.sh /tmp/install.sh

# Run install script
RUN bash /tmp/install.sh && rm /tmp/install.sh

# Expose ports for SSH and GDB
EXPOSE 22 7777
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Add dev user with password dev
RUN useradd -ms /bin/bash dev
RUN echo 'root:root' | chpasswd

#ENV PATH="/opt/rh/devtoolset-8/root/bin/:${PATH}"
#ENV LD_LIBRARY_PATH="/usr/lib/gcc/x86_64-redhat-linux/8/:${LD_LIBRARY_PATH}"
#RUN echo "source /opt/rh/devtoolset-10/enable" >> /etc/profile.d/devtoolset-10
#RUN chmod +x /etc/profile.d/devtoolset-10

# 为了镜像里有 yum
RUN yum install -y gcc

CMD ["/start.sh"]
