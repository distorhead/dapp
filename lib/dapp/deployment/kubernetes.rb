module Dapp
  module Deployment
    class Kubernetes
      def initialize
        config = Kubeclient::Config.new(YAML.load_file(File.join(ENV['HOME'], '.kube/config')), '')

        @client = Kubeclient::Client.new(
          config.context.api_endpoint,
          config.context.api_version,
          ssl_options: config.context.ssl_options
        )
      end

      protected

      attr_reader :client
    end
  end
end
