FROM python:3
MAINTAINER mathias.kluba@gmail.com

WORKDIR /usr/src/app

# download ambari script and build
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get install -y git && \
    git clone https://github.com/grozeille/ambari-cli.git && \
    cd ambari-cli && \
    git checkout tags/1.4 && \
    pyb publish  && \
    pip install target/dist/ambari-cli-1.5/dist/ambari-cli-1.5.tar.gz


COPY . .

RUN chmod a+x /usr/src/app/deploy.py