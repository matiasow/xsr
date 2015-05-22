require 'xsr'
require_relative 'helper'

# Tests for SSL requests
module ClientSSLTest
  prepare do
    @client = XSR::Client.new(base_url: 'https://httpbin.org')
  end

  test 'https request' do
    resp = @client.get('/get')

    assert resp.http_response.instance_of?(Net::HTTPOK)
  end

  test 'https request skipping certificate verification' do
    resp = @client.get('/get', skip_cert_check: true)

    assert resp.http_response.instance_of?(Net::HTTPOK)
  end

  test 'client skip certificate verification' do
    client = XSR::Client.new(base_url: 'https://httpbin.org', skip_cert_check: true)
    resp = client.get('/get')

    assert resp.http_response.instance_of?(Net::HTTPOK)
  end

  test 'set custom invalid ca pem' do
    @client.ca_file = 'does_not_exist.pem'
    
    assert_raise(OpenSSL::SSL::SSLError) do
      @client.get('/get')
    end
  end
end
