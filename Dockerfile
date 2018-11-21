FROM debian:9

RUN apt update && apt install -y curl gnupg2 python3-pip && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt install -y nodejs && \
    npm install -g webpack webpack-cli nodemon && \
    pip3 install awscli && \
    useradd -ms /bin/bash node && \
    apt remove -y curl gnupg2 python3-pip && \
    apt autoremove -y && rm -rf /var/lib/apt/lists/

EXPOSE 3000

VOLUME [ "/app" ]

WORKDIR /app

USER node

CMD [ "nodemon", "src/index.js" ]