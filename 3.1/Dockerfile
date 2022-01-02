# vim:set ft=dockerfile:

FROM cimg/base:2021.10

LABEL maintainer="CircleCI Community & Partner Engineering Team <community-partner@circleci.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV DOTNET_VERSION=3.1

RUN wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
        sudo dpkg -i packages-microsoft-prod.deb && \
        rm packages-microsoft-prod.deb

RUN sudo apt-get update; \
    sudo apt-get install -y apt-transport-https && \
    sudo apt-get update && \
    sudo apt-get install -y dotnet-sdk-${DOTNET_VERSION}

RUN dotnet help && dotnet --list-sdks && dotnet --list-runtimes
