from ubuntu:latest
RUN apt-cache search clang
RUN apt-get update
RUN echo "update"
RUN apt-get upgrade -y

RUN apt-cache search clang
#install developer dependencies
RUN apt-get install clang -y
RUN apt-get install cmake -y
RUN apt-get install git -y
RUN apt-get install curl -y
RUN apt-get install zip -y
RUN apt-get install gdb -y
RUN apt-get install pkg-config -y



#install vcpkg package manager
RUN git clone --depth 1 https://github.com/microsoft/vcpkg
RUN ./vcpkg/bootstrap-vcpkg.sh

#install packages for project

RUN /vcpkg/vcpkg install boost


# Create local user to avoid file permission issues
ARG USERNAME=developer 

ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt install sudo -y


RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # add sudo support
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

RUN sudo chown -R $USERNAME /vcpkg 

RUN /vcpkg/vcpkg install cpp-netlib
# set work directory for project
WORKDIR /Project

RUN sudo chown -R $USERNAME /Project 


