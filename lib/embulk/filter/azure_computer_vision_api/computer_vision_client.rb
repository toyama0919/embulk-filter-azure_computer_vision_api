require "json"
require "net/http"
require "uri"
require "pp"
require "openssl"

module Embulk
  module Filter
    class AzureComputerVisionApi < FilterPlugin
      class ComputerVisionClient
        ENDPOINT_PREFIX = "https://api.projectoxford.ai/vision/v1.0"
        RETRY_WAIT_REGEXP = /Rate limit is exceeded. Try again in ([\d]+) seconds./

        def initialize(params: , subscription_key:, api_type: , retry_wait:, read_timeout:)
          Embulk.logger.info("api type => #{api_type}")

          uri = URI.parse("#{ENDPOINT_PREFIX}/#{api_type}")
          uri.query = URI.encode_www_form(params)
          @api_type = api_type
          @request = Net::HTTP::Post.new(uri.request_uri)
          @request['Ocp-Apim-Subscription-Key'] = subscription_key
          @http = Net::HTTP.new(uri.host, uri.port)
          @http.read_timeout = read_timeout
          @http.use_ssl = true
          @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          @retry_wait = retry_wait
        end

        def request(image_path)
          content_type, body = get_content_type_and_body(image_path)
          @request['Content-Type'] = content_type
          @request.body = body

          Embulk.logger.info("Computer Vision API #{@api_type} processing.. => #{image_path}")

          begin
            loop do
              response = @http.start do |http|
                response_body = http.request(@request).body
                Embulk.logger.debug("response body => #{response_body}")
                JSON.parse(response_body)
              end
              if response.key?('statusCode')
                if response['statusCode'] == 429
                  sec = response['message'].match(RETRY_WAIT_REGEXP)
                end
                Embulk.logger.warn("response error => #{response}")
                sleep (sec ? sec[1].to_i + 1 : @retry_wait)
              else
                return response
              end
            end
          rescue => e
            Embulk.logger.error "\n#{e.message}\n#{e.backtrace.join("\n")}"
          end
        end

        private
        def get_content_type_and_body(image_path)
          if image_path =~ /https?\:\/\//
            return 'application/json', { url: image_path || '' }.to_json
          else
            content = File.read(image_path) rescue ''
            return 'application/octet-stream', content
          end
        end
      end
    end
  end
end
