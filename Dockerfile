FROM python:3
MAINTAINER mathias.kluba@gmail.com

WORKDIR /usr/src/app

# download ambari script and build
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get install -y git && \
    git clone https://github.com/grozeille/ambari-cli.git && \
    cd ambari-cli && \
    git checkout tags/1.2 && \
    pyb publish  && \
    pip install target/dist/ambari-cli-1.2/dist/ambari-cli-1.2.tar.gz


COPY . .