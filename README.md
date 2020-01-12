# docker-node-webpack
Docker image based on Debian for testing, bundling and deploying NodeJS 8, 10 and 12
apps on AWS lambda using webpack

## packaged with:

- awscli
- nodejs
  - Version 8 (fredbourni/node-webpack:8)
  - Version 10 (fredbourni/node-webpack:10)
  - Version 12 (fredbourni/node-webpack:12, fredbourni/node-webpack:12-webp)
- nodemon
- webp (fredbourni/node-webpack:12-webp only)
- webpack-cli

## examples:

### developing

```
# Install dependencies
docker run --rm -v $PWD:/app -u $UID fredbourni/node-webpack npm install

# Start test server (nodemon)
docker run --rm -v $PWD:/app -u $UID fredbourni/node-webpack nodemon index.js

# or simply this command if main script is "src/index.js"
docker run --rm -v $PWD:/app -u $UID fredbourni/node-webpack

# Run script
docker run --rm -v $PWD:/app -u $UID fredbourni/node-webpack node src/task.js
```

### bundling

```
docker run --rm -v $PWD:/app -u $UID fredbourni/node-webpack \
  webpack --mode production --target node --output-library main --output-library-target umd

docker run --rm -v $PWD/dist:/app -u $UID fredbourni/node-webpack zip main main.js
```

### deploying

```
docker run --rm -v $HOME/.aws:/home/node/.aws -v $PWD:/app \
  -u $UID fredbourni/node-webpack \
  aws s3 --profile profilename cp dist/main.zip  s3://bucketname/main.zip && \
  aws lambda update-function-code --profile profilename --function-name fname \
  --s3-bucket bucketname --s3-key main.zip
```