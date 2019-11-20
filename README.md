# docker-node-webpack
Docker image based on Debian for testing, bundling and deploying NodeJS 8, 10 and 12
apps on AWS lambda using webpack

## packaged with:

- awscli
- nodejs 8, 10 or 12 (tags)
- nodemon
- webpack-cli

## examples:

### developing

```
# Install dependencies
docker run --rm -v $PWD:/app -w /app -u $UID fredbourni/node-webpack nodemon index.js

# Start test server
docker run --rm -v $PWD:/app -w /app -u $UID fredbourni/node-webpack nodemon index.js

# Run script
docker run --rm -v $PWD:/app -w /app -u $UID fredbourni/node-webpack node src/task.js
```

### bundling

```
docker run --rm -v $PWD:/app -w /app -u $UID fredbourni/node-webpack \
  webpack --mode production --target node --output-library main --output-library-target umd

cd dist && zip main main.js
```

### deploying

```
docker run --rm -v $HOME/.aws:/home/node/.aws -v $PWD:/app \
  -w /app -u $UID fredbourni/node-webpack \
  aws s3 --profile profilename cp dist/main.zip  s3://bucketname/main.zip && \
  aws lambda update-function-code --profile profilename --function-name fname \
  --s3-bucket bucketname --s3-key main.zip
```