FROM kobaha/ubuntu-14.04-oracle-jdk:jdk7

MAINTAINER kobyaha <kobyahron@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y bzip2 curl && apt-get clean

# Download and extract android studio
RUN curl https://dl.google.com/android/studio/install/0.8.6/android-studio-bundle-135.1339820-linux.tgz | \
	tar -xvz -C /usr/local/

# Add android tools and platform tools to PATH
ENV ANDROID_STUDIO /usr/local/android-studio
ENV ANDROID_HOME $ANDROID_STUDIO/sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools

# Install latest android (19 / 4.4.2) tools and system image.
RUN echo "y" | android update sdk --no-ui --force --filter platform-tools,android-19,build-tools-20.0.0


# Installing XServer to support GUI

RUN apt-get install -y openssh-server xdm xvfb

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config
RUN echo PermitRootLogin yes >> /etc/ssh/ssh_config # Check if I should remove this line

ADD . /src

EXPOSE 22

# Start xdm and ssh services.
#CMD ["/bin/bash", "/src/startup.sh"]
CMD ["/src/startup.sh"]
