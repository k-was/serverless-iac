# Serverless Outyet Application

The application pings https://go.googlesource.com/go/+/go1.4 to check if Golang 1.4 has been released and renders the proper HTML template if the Head request returns a 200 response code.

This repo contains source code from the outyet golang.
https://github.com/golang/example/tree/master/outyet

The code needed to be modified in order to run on AWS Lambda

The following changes were made:
- Added the github.com/apex/gateway package as a lambda friendly replacement for the net/http ListenAndServe function
- Added a waitgroup to the server struct to ensure that  the polling go routine executed. This needed to be done as the go routine was not completed upon lambda execution. (Most likely beacuse the lambda fire up upon request) Did not notice significant latency upon addition of this wait group.

- I added a header to set the content type to html to make sure the client browser renders the Html properly (As oppose to application/json containing HTML).

*The changes are also annotated within the code*


# Pre-Req
There are a few pre-requisites for boot-strapping/deploying this serverless application

- Need golang installed (This should ideally be ran on a CI server)

We need
```
```

aws apigateway get-rest-apis
