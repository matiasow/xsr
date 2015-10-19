require 'xsr'
require_relative 'helper'

# Tests for Response class
module ResponseTest
  prepare do
    @client = XSR::Client.new(base_url: 'http://httpbin.org')
  end

  test 'initialize' do
    http_response = Net::HTTP.new('http://google.com')
    @res = XSR::Response.new(http_response)
    assert_equal @res.http_response, http_response
  end

  test 'status 200 gets a successful response' do
    res = @client.get('/status/200')
    assert res.success?
    assert_equal res.status, '200'
  end

  test 'status 201 gets a successful response' do
    res = @client.get('/status/201')
    assert res.success?
  end

  test 'status 202 gets a successful response' do
    res = @client.get('/status/202')
    assert res.success?
  end

  test 'status 400 gets a Bad Request response' do
    res = @client.get('/status/400')
    assert !res.success?
    assert res.bad_request?
  end

  test 'status 401 gets an Unauthorized response' do
    res = @client.get('/status/401')
    assert !res.success?
    assert res.unauthorized?
  end

  test 'status 403 gets a Forbidden response' do
    res = @client.get('/status/403')
    assert !res.success?
    assert res.forbidden?
  end

  test 'status 404 gets a Not Found response' do
    res = @client.get('/status/404')
    assert !res.success?
    assert res.not_found?
    assert_equal res.status, '404'
  end

  test 'status 500 gets a Server Error response' do
    res = @client.get('/status/500')
    assert !res.success?
    assert res.server_error?
    assert_equal res.status, '500'
  end

  test 'simple json response' do
    req = { some_attrib: 'some_value' }
    res = @client.post('/post', body: req)

    assert res.success?
    assert_equal res.body[:json], req
  end

  test 'json response with nested attributes' do
    req = { something: { some_attrib: 'some_value' } }
    res = @client.post('/post', body: req)

    assert res.success?
    assert_equal res.body[:json], req
  end
end
