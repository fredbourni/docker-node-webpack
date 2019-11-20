FROM debian:10

RUN apt update && apt install -y gnupg2 curl python3-pip zip && \
    pip3 install awscli && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt install -y nodejs && \
    npm install -g webpack webpack-cli nodemon && \
    apt remove -y gnupg2 && \
    apt autoremove -y && rm -rf /var/lib/apt/lists/ && \
    useradd -ms /bin/bash node    

EXPOSE 3000

VOLUME [ "/app" ]

WORKDIR /app

USER node

CMD [ "nodemon", "src/index.js" ]