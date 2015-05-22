module XSR
  # XSR Client class, holding methods to handle HTTP requests
  class Client
    attr_accessor :base_url
    attr_accessor :default_header
    attr_accessor :skip_cert_check
    attr_accessor :ca_file

    def initialize(options = {})
      @base_url = options[:base_url]
      @base_header = options[:header]
      @skip_cert_check = options[:skip_cert_check]
      @ca_file = options[:ca_file]
    end

    def post(path, options = {})
      request_with_data(path, options) { |uri| Net::HTTP::Post.new(uri.to_s) }
    end

    def delete(path, options = {})
      request_with_data(path, options) { |uri| Net::HTTP::Delete.new(uri.to_s) }
    end

    def put(path, options = {})
      request_with_data(path, options) { |uri| Net::HTTP::Put.new(uri.to_s) }
    end

    def get(path, options = {})
      request_with_data(path, options) { |uri| Net::HTTP::Get.new(uri.to_s) }
    end

    private

    def request_with_data(path, options = {})
      # Set URI & arguments
      args = options[:args] && URI.encode(options[:args].map { |k, v| "#{k}=#{v}" }.join('&').to_s)
      uri = URI(@base_url.to_s + path.to_s + '?' + args.to_s)

      req = yield(uri)

      # Set headers
      req['Content-Type'] = 'application/json'
      @base_header && @base_header.each { |k, v| req[k.to_s] = v }
      options[:header] && options[:header].each { |k, v| req[k.to_s] = v }

      # Set body
      req.body = options[:body] && MultiJson.dump(options[:body])

      http_session = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https' # Requires SSL?
        http_session.use_ssl = true
        if @skip_cert_check || options[:skip_cert_check]
          http_session.verify_mode = OpenSSL::SSL::VERIFY_NONE
        else
          http_session.ca_file = @ca_file || options[:ca_file]
          http_session.verify_mode = OpenSSL::SSL::VERIFY_PEER
        end
      end

      XSR::Response.new http_session.start { |http| http.request(req) }
    end
  end
end
