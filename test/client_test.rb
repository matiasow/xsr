require 'xsr'
require_relative 'helper'

# Tests for Client class
module ClientTest
  prepare do
    @client = XSR::Client.new(base_url: 'http://httpbin.org')
  end

  test 'get request' do
    resp = @client.get('/get')

    assert resp.http_response.instance_of?(Net::HTTPOK)
  end

  test 'post request' do
    req = { some_key: 'some_value' }
    resp = @client.post('/post', body: req)

    assert resp.http_response.instance_of?(Net::HTTPOK)
    assert_equal MultiJson.load(resp.http_response.body,
                                symbolize_keys: true)[:json], req
  end

  test 'put request' do
    req = { some_key: 'some_value' }
    resp = @client.put('/put', body: req)

    assert resp.http_response.instance_of?(Net::HTTPOK)
    assert_equal MultiJson.load(resp.http_response.body,
                                symbolize_keys: true)[:json], req
  end

  test 'delete request' do
    req = { some_key: 'some_value' }
    resp = @client.delete('/delete', body: req)

    assert resp.http_response.instance_of?(Net::HTTPOK)
    assert_equal MultiJson.load(resp.http_response.body,
                                symbolize_keys: true)[:json], req
  end

  test 'headers are passed to request' do
    h = { 'Some-Header' => 'some_value' }
    resp = @client.get('/headers', header: h)

    assert resp.http_response.instance_of?(Net::HTTPOK)

    header = MultiJson.load(resp.http_response.body)['headers']['Some-Header']
    assert_equal header, 'some_value'
  end

  test 'default headers are passed to request' do
    h = { 'Some-Header' => 'some_value' }
    resp = XSR::Client.new(header: h).get('http://httpbin.org/headers')

    assert resp.http_response.instance_of?(Net::HTTPOK)

    header = MultiJson.load(resp.http_response.body)['headers']['Some-Header']
    assert_equal header, 'some_value'
  end

  test 'query string arguments are passed to request' do
    p = { some_arg: 'some_value' }
    resp = @client.get('/get', args: p)

    assert resp.http_response.instance_of?(Net::HTTPOK)

    argument = MultiJson.load(resp.http_response.body)['args']['some_arg']
    assert_equal argument, 'some_value'
  end
end
