require_relative 'azure_computer_vision_api/constants'
require_relative 'azure_computer_vision_api/computer_vision_client'

module Embulk
  module Filter
    class AzureComputerVisionApi < FilterPlugin
      Plugin.register_filter("azure_computer_vision_api", self)

      def self.transaction(config, in_schema, &control)
        task = {
          "api_type" => config.param("api_type", :string),
          "out_key_name" => config.param("out_key_name", :string),
          "image_path_key_name" => config.param("image_path_key_name", :string),
          "params" => config.param("params", :hash, default: {}),
          "delay" => config.param("delay", :integer, default: 0),
          "retry_wait" => config.param("retry_wait", :integer, default: 10),
          "read_timeout" => config.param("read_timeout", :integer, default: 60),
          "subscription_key" => config.param("subscription_key", :string),
        }

        add_columns = [
          Column.new(nil, task["out_key_name"], :json)
        ]

        out_columns = in_schema + add_columns

        yield(task, out_columns)
      end

      def init
        @image_path_key_name = task['image_path_key_name']
        @delay = task['delay']
        @client = ComputerVisionClient.new(
          params: task['params'],
          subscription_key: task['subscription_key'],
          retry_wait: task['retry_wait'],
          read_timeout: task['read_timeout'],
          api_type: task['api_type']
        )
      end

      def close
      end

      def add(page)
        page.each do |record|
          hash = Hash[in_schema.names.zip(record)]
          response = @client.request(hash[@image_path_key_name])
          page_builder.add(hash.values + [response])
          sleep @delay
        end
      end

      def finish
        page_builder.finish
      end
    end
  end
end
