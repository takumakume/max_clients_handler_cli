module MaxClientsHandlerCli
  module Config
    default_config = "/access_limiter/max_clients_handler_cli.yaml"
    CONFIG_PATH = (ENV.key?("MAX_CLIENTS_HANDLER_CLI_CONFIG") ? ENV["MAX_CLIENTS_HANDLER_CLI_CONFIG"] : default_config)
  end
end
