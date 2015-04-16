## RESTful API Playground

My template for working with sample REST API using NodeJS and CoffeeScript

## Basic Usage

- First build the app using npm

```shell
mkdir -p ~/codes && cd ~/codes
git clone git@github.com:agilecreativity/restful-playground.git
cd ~/codes/restful-playground
npm install

# Create the sample seed file
coffee ./seeds.coffee

# Run the server and see
./run-server

# Or if using Gulp
gulp
```

- Then open your browser to [http://localhost:3000/api/books](http://localhost:3000/api/books)

## Testing

```shell
./run-test
```

Or if using Gulp

```
gulp test
```

## TODO

- Make `gulpfile.js` work with CoffeeScript
- Remove all of the `*.js` file

## Links
