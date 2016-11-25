def __main__(argv)
  MaxClientsHandlerCli.initialize

  opts = Getopts.getopts("vhm:c:k:t:", "version", "help", "get_config", "full")

  if opts["v"] || opts["version"]
    puts "#{MaxClientsHandlerCli.version}"
    return 0
  end

  if opts["h"] || opts["help"]
    puts "#{MaxClientsHandlerCli.help}"
    return 0
  end

  if opts["get_config"]
    puts "#{MaxClientsHandlerCli.get_config}"
    return 0
  end

  unless opts.has_key?("m")
    puts "MaxClientsHandlerCli: -m option is required"
    puts "#{MaxClientsHandlerCli.help}"
    return 1
  end

  apply_flag = false
  case opts["m"]
  when "get"
    v = YAML.dump(MaxClientsHandlerCli.get opts)
    return 1 if v.nil?
    puts "#{v}"

  when "get_all"
    v = MaxClientsHandlerCli.get_all
    return 1 if v.nil?
    if opts.has_key?("full")
      puts YAML.dump(v)
    else
      v.keys.each do |key|
        puts key
      end
    end

  when "set"
    if MaxClientsHandlerCli.set opts
      puts "MaxClientsHandlerCli: set: successful"
    else
      puts "MaxClientsHandlerCli: set: execute failed"
      return 1
    end
    v = YAML.dump(MaxClientsHandlerCli.get opts)
    puts "#{v}"
    apply_flag = true

  when "delete"
    if MaxClientsHandlerCli.delete opts
      MaxClientsHandlerCli.clear_counter opts
      puts "MaxClientsHandlerCli: delete: successful"
    else
      puts "MaxClientsHandlerCli: delete: execute failed"
      return 1
    end
    apply_flag = true

  when "lmc_get"
    v = MaxClientsHandlerCli.lmc_get opts
    return 1 if v.nil?
    puts "#{v}"

  when "apply"
    puts "#{MaxClientsHandlerCli.get_all}"
    apply_flag = true
  else
    puts "MaxClientsHandlerCli: unknown option"
    puts "#{MaxClientsHandlerCli.help}"
    return 1
  end

  if apply_flag
    if MaxClientsHandlerCli.apply
      puts "MaxClientsHandlerCli: apply: successful"
    else
      puts "MaxClientsHandlerCli: apply: execute failed"
      return 1
    end
  end

  return 0
end
