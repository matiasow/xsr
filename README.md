# XSR - eXtremely Simple REST client

[![Join the chat at https://gitter.im/matiasow/xsr](https://badges.gitter.im/matiasow/xsr.svg)](https://gitter.im/matiasow/xsr?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Gem Version](https://badge.fury.io/rb/xsr.svg)][gem]
[![Dependency Status](https://gemnasium.com/matiasow/xsr.svg)][gemnasium]
[![Code Climate](https://codeclimate.com/github/matiasow/xsr/badges/gpa.svg)][codeclimate]
[![Build Status](https://travis-ci.org/matiasow/xsr.svg?branch=master)][travis]
[![Test Coverage](https://codeclimate.com/github/matiasow/xsr/badges/coverage.svg)][codeclimate]

[gem]: http://badge.fury.io/rb/xsr
[gemnasium]: https://gemnasium.com/matiasow/xsr
[codeclimate]: https://codeclimate.com/github/matiasow/xsr
[travis]: https://travis-ci.org/matiasow/xsr

XSR is an extremely simple REST client aimed to use against JSON/REST APIs.

## Installation

Simply run

``` console
$ gem install xsr
```

### Using Rails?

Add the following line to your Gemfile:

``` ruby
gem 'xsr'
```

## Usage

Create a new instance of XSR client specifying the base_url for wich you will be requesting further paths:

``` ruby
require 'xsr'
client = XSR::Client.new
```

And then invoke a service:

``` ruby
resp = client.get('http://api.something.io')
resp.success?
#=> true
resp.body
#=> JSON response as a Ruby Hash Object
```
###Supported HTTP verbs
Implemented verbs are GET, POST, PUT and DELETE. To change the verb simply invoke the corresponding method:
####HTTP GET
This will make a HTTP GET request to http://api.something.io
``` ruby
client.get('http://api.something.io')
```
####HTTP POST
This will make a HTTP POST request to http://api.something.io
``` ruby
client.post('http://api.something.io')
```
####HTTP PUT
This will make a HTTP PUT request to http://api.something.io
``` ruby
client.put('http://api.something.io')
```
####HTTP DELETE
This will make a HTTP DELETE request to http://api.something.io
``` ruby
client.delete('http://api.something.io')
```

###Using query string arguments
This will make a HTTP GET request to http://api.somthing.io?arg1=a&arg2=b
``` ruby
client.get('http://api.something.io', args: {arg1: 'a', arg2: 'b'})
```

###Passing JSON arguments in request body
``` ruby
req = { some_key: some_value, other_key: [1,2,3] }
client.post('http://api.something.io', body: req)
```

###Using HTTP headers
This will make a HTTP GET request to http://api.somthing.io passing 'Some-Header: Some-Value' in the HTTP headers
``` ruby
resp = client.get('http://api.something.io', header: {some_header: 'some_value'})
```

###Response object
HTTP response comes in the form of a ```XSR::Response``` object:
``` ruby
resp = client.post('http://api.something.io')

resp.success?
#=> Response status code is 2xx

resp.bad_request?
#=> Response status code is 400

resp.unauthorized?
#=> Response status code is 401

resp.forbidden?
#=> Response status code is 403

resp.not_found?
#=> Response status code is 404

resp.server_error?
#=> Response status code is 500

resp.body
#=> JSON response as a Ruby Hash object

resp.http_response
#-> Call http_response to get full Net::HTTPResponse object
```

### SSL considerations
By default, XSR verifies the SSL certificate for the requested server. 

To use a custom CA Root certificate set ```ca_file```
```
client = XSR::Client.new(ca_file: '/path/to/my_custom.pem')
client.get('https://api.something.io/get')
```

In case you want to skip this verfication, set ```skip_cert_check```:
```
client = XSR::Client.new(skip_cert_check: true)
client.get('https://api.something.io/get')
```

##What's next?
I'm not planning to add more features right now, but feel free to fork this repo and add any extra functionality you consider that should be included. Please, submit a PR with proposed changes or fixes.
Just keep in mind a minimalist paradigm (https://youtu.be/tXVr2E1vfmk).

##License

XSR is released under the [MIT License](http://www.opensource.org/licenses/MIT).
