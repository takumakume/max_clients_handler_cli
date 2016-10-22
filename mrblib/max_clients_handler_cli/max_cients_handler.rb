module MaxClientsHandlerCli
  class << self
    def load_store
      path = @@config["config_store_yaml"]
      s = nil
      begin
        s = YAML.load(File.open(path).read())
      rescue => e
        raise "load_store: can't load yaml #{path} #{e}"
      end
      s
    end

    def get opts
      unless opts.has_key?("k") && opts["k"]
        puts "get: -k options is required"
        return false
      end
      key = opts["k"]
      s = self.load_store
      s[key] if s && s.has_key?(key)
    end

    def get_all
      s = self.load_store
    end

    def set opts
      unless opts.has_key?("k") || opts["k"] == ""
        puts "set: -k options is required"
        return false
      end

      unless opts.has_key?("c")
        opts["c"] = 10
      end

      key = opts["k"].to_s
      max_clients = opts["c"].to_i
      time_slots = []

      if opts.has_key?("t")
        tmp = opts["t"].split(",")
        tmp.each do |t|
          a = t.split("-")
          raise "set: time_slots format error #{t}" unless a.size == 2

          b = a[0].to_i
          e = a[1].to_i
          raise "set: time_slots format error begin > end #{t}" if b > e

          time_slots.push({ "begin" => b, "end" => e })
        end
      end

      store = self.load_store
      store = {} if store.nil?

      store[key] = {
        "max_clients" => max_clients,
        "time_slots" => time_slots
      }

      begin
        y = YAML.dump(store)
        File.open(@@config["config_store_yaml"], "w").syswrite(y)
        return true
      rescue => e
        raise "set: write yaml error #{e}"
      end
      false
    end

    def delete opts
      unless opts.has_key?("k") || opts["k"] == ""
        puts "delete: -k options is required"
        return false
      end

      store = self.load_store
      return nil if store.nil?

      key = opts["k"]
      if store.has_key?(key)
        store.delete(key)
      else
        return false
      end

      begin
        y = YAML.dump(store)
        File.open(@@config["config_store_yaml"], "w").syswrite(y)
        return true
      rescue => e
        raise "delete: write yaml error #{e}"
      end
      false
    end

    def lmc_get opts
      unless opts.has_key?("k") && opts["k"]
        puts "lmc_get: -k options is required"
        return false
      end

      key = opts["k"]

      j = nil
      begin
        lmc = Cache.new :filename => @@config["config_store_lmc"]
        j = lmc[key]
        lmc.close
      rescue => e
        raise "lmc_get: localmemcache get error #{e}"
      end
      j
    end

    def apply
      begin
        lmc = nil
        begin
          lmc = Cache.new :filename => @@config["config_store_lmc"]
        rescue => e
          raise "apply: localmemcache open and clear error #{e}"
        end

        store = self.load_store

        if store.nil?
          lmc.clear
          lmc.close
          return true
        end

        # check format
        store.each do |s|
          raise "apply: check format fail #{s}" unless s.size == 2 && s[1].has_key?("max_clients") && s[1].has_key?("time_slots")
          s[1]["time_slots"].each do |t|
            raise "apply: check format fail time_slots #{t}" unless t.has_key?("begin") && t.has_key?("end")
          end if s[1]["time_slots"].is_a?(Array)
        end

        lmc.clear

        store.each do |s|
          key = s[0].to_s
          val = s[1].to_json
          lmc[key] = val.to_s
        end

        lmc.close
      rescue => e
        raise "apply: error #{e}"
      end
      true
    end

    def get_config
      @@config
    end
  end
end
