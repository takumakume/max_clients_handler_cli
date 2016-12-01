module MaxClientsHandlerCli
  class << self
    def help
<<-EOF

Usage:

  # get: Show config from yaml config store
  $ max_clients_handler_cli -m get -k [KEY]
  $ max_clients_handler_cli -m get -k /path/to/hoge.php

  # get_all: Show all config keys from yaml config store (show with value add option `--full`)
  $ max_clients_handler_cli -m get_all
  $ max_clients_handler_cli -m get_all --full

  # set: Set config from yaml after apply localmemcache
  $ max_clients_handler_cli -m set -k [KEY] -c [max_clients] -t [timeslot(,timeslot)]
  $ max_clients_handler_cli -m set -k /path/to/hoge.php -c 10 -t 1200-1500,2030-2359

  # delete: Delete config from yaml after apply localmemcache
  $ max_clients_handler_cli -m delete -k [KEY]
  $ max_clients_handler_cli -m delete -k /path/to/hoge.php

  # lmc_get: Show config from direct localmemcache config store
  $ max_clients_handler_cli -m lmc_get -k [KEY]
  $ max_clients_handler_cli -m lmc_get -k /path/to/hoge.php

  # apply: Apply config yaml -> localmemcache
  $ max_clients_handler_cli -m apply

  # get_config: Show cli configration
  $ max_clients_handler_cli --get_config

  # config file path if not default
  $ MAX_CLIENTS_HANDLER_CLI_CONFIG=/path/to/max_clients_handler_cli.yaml max_clients_handler_cli [options]
EOF
    end
  end
end
