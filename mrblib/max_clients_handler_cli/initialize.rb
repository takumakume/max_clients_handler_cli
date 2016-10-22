module MaxClientsHandlerCli
  @@config = {}

  class << self
    def load_config path
      begin
        @@config = YAML.load(File.open(path).read())
      rescue => e
        puts "load_config: #{path} config load error #{e}"
        return false
      end
    end

    def initialize
      self.load_config Config::CONFIG_PATH

      @@config["config_store_lmc"] = "/access_limiter/max_clients_hander.lmc" unless @@config.has_key?("config_store_lmc")
      unless File.exists?(@@config["config_store_lmc"])
        begin
          Cache.new :filename => @@config["config_store_lmc"]
          puts "initialize: new create #{@@config["config_store_lmc"]}"
        rescue => e
          puts "initialize: can't create #{@@config["config_store_lmc"]} #{e}"
        end
      end

      @@config["config_store_yaml"] = "/access_limiter/max_clients_hander.yaml" unless @@config.has_key?("config_store_yaml")
      unless File.exists?(@@config["config_store_yaml"])
        begin
          File.open(@@config["config_store_yaml"], "w")
          puts "initialize: new create #{@@config["config_store_yaml"]}"
        rescue => e
          puts "initialize: can't create #{@@config["config_store_yaml"]} #{e}"
          return false
        end
      end
    end
  end
end
