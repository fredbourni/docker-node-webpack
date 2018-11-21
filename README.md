# docker-node-webpack
Docker image based on Debian Strech for testing, building and deploying Node v8 app on AWS lambda

## packaged with:

- awscli
- nodejs 8
- nodemon
- webpack-cli

## examples:

### developing

```
docker run --rm -v $PWD:/app -w /app -u $UID fredbourni/node-webpack nodemon index.js
```

### bundling

```
docker run --rm -v $PWD:/app -w /app -u $UID fredbourni/node-webpack \
  webpack --mode production --target node --output-library main --output-library-target umd
```

### deploying

```
docker run --rm -v $PWD:/app -w /app -u $UID fredbourni/node-webpack \
  aws s3 --profile profilename cp dist/main.zip  s3://bucketname/main.zip && \
  aws lambda update-function-code --profile profilename --function-name fname \
  --s3-bucket bucketname --s3-key main.zip
```