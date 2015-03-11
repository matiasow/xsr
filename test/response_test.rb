require 'xsr'
require_relative 'helper'

module ResponseTest
  prepare do
    @client = XSR::Client.new( base_url: 'http://httpbin.org' )
  end

  test "status 200 is a successful response" do
    resp = @client.get('/status/200')
    assert resp.success?
  end

  test "status 201 is a successful response" do
    resp = @client.get('/status/201')
    assert resp.success?
  end

  test "status 202 is a successful response" do
    resp = @client.get('/status/202')
    assert resp.success?
  end

  test "status 400 is a successful response" do
    resp = @client.get('/status/400')
    assert !resp.success?
    assert resp.bad_request?
  end

  test "status 404 is a successful response" do
    resp = @client.get('/status/404')
    assert !resp.success?
    assert resp.not_found?
  end

  test "status 500 is a successful response" do
    resp = @client.get('/status/500')
    assert !resp.success?
    assert resp.server_error?
  end

  test "simple body" do
    req = {some_attrib: 'some_value'}
    resp = @client.post('/post', body: req)
    
    assert resp.success?
    assert_equal resp.body[:json], req
  end

  test "body with nested attributes" do
    req = {something: {some_attrib: 'some_value'}}
    resp = @client.post('/post', body: req)
    
    assert resp.success?
    assert_equal resp.body[:json], req
  end
end