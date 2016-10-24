# max_clients_handler_cli

### This middleware config tool

[matsumoto-r/http-access-limiter](https://github.com/matsumoto-r/http-access-limiter)

  - with `MaxClientsHandler` class

### build & install

  ```
  git clone https://github.com/takumakume/max_clients_handler_cli.git
  cd max_clients_handler_cli
  rake

  cp -p mruby/bin/max_clients_handler_cli /usr/local/bin/
  ```

### depends mgems

  ```ruby
  conf.gem :github => 'mttech/mruby-getopts'
  conf.gem :github => 'AndrewBelt/mruby-yaml'
  conf.gem :github => 'matsumoto-r/mruby-localmemcache'
  conf.gem :github => 'iij/mruby-iijson'
  conf.gem :github => 'iij/mruby-env'
  ```

### How to use

##### Options

| Option        | Description |
| ----          | ----        |
| -v, --version | Show this version |
| -h, --help    | Show this usage |
| --get_config  | Show this configration |
| -m [get/get_all/set/delete/lmc_get/apply] | Specified command mode |
| -k KEY | Specified config key |
| -c MAX_CLIENTS | Specified set max_clients number (default: 10) |
| -t TIME_SLOTS | Specified set max_clients number (default: null) |

##### Mode (-m)

| Mode    | Description |
| ----    | ----        |
| get     | Show config from yaml config store |
| get_all | Show all config keys from yaml config store (show with value add option `--full`) |
| set     | Set config from yaml after apply localmemcache |
| delete  | Delete config from yaml after apply localmemcache |
| lmc_get | Show config from direct localmemcache config store |
| apply   | Apply config yaml -> localmemcache |

##### time_slots (-t)

- Default is null (It’s setting is always enabled)
- Specifying
  - Single time slot

    ```shell
    # 09:00 ~ 10:30
    -t 900-1030
    ```

  - Two or more time slots

    ```shell
    # 09:00 ~ 10:30 and 21:00 ~ 23:59
    -t 900-1030,2100-2359
    ```

##### Optional global env

- MAX_CLIENTS_HANDLER_CLI_CONFIG
  - Specified not default config file
  - default config file path : `/access_limiter/max_clients_handler_cli.yaml`

##### Configration max_clients_handler_cli

- `/access_limiter/max_clients_handler_cli.yaml`

| Config Name | Description | Default |
| ----        | ----        | ----    |
| config_store_yaml | http-access-limiter limit condition config store path (YAML) | /access_limiter/max_clients_hander.yaml |
| config_store_lmc  | http-access-limiter limit condition config store path (localmemcache) | /access_limiter/max_clients_hander.lmc  |

##### usage

###### Specified not default config file

  ```shell
  $ MAX_CLIENTS_HANDLER_CLI_CONFIG=/path/to/max_clients_handler_cli.yaml max_clients_handler_cli [options]
  ```

###### get

  ```shell
  $ max_clients_handler_cli -m get -k /path/to/test.php
  ---
  max_clients: 10
  time_slots:
  - begin: 1000
    end: 1200
  ...
  ```

###### lmc_get

  ```shell
  $ max_clients_handler_cli -m lmc_get -k /path/to/test.php
  {"max_clients":10,"time_slots":[{"begin":1000,"end":1200}]}
  ```

###### get_all

  ```shell
  $ max_clients_handler_cli -m get_all
  /path/to/test.php
  /path/to/hoge.php
  ```

  - show full value

    ```shell
    $ max_clients_handler_cli -m get_all --full
    ---
    /path/to/test.php:
      max_clients: 10
      time_slots:
      - begin: 1000
        end: 1200
    /path/to/hoge.php:
      max_clients: 10
      time_slots: []
    ...
    ```

###### set

  ```shell
  $ max_clients_handler_cli -m set -k /path/to/test.php -c 10 -t 1000-1200
  MaxClientsHandlerCli: set: successful
  ---
  max_clients: 10
  time_slots:
  - begin: 1000
    end: 1200
  ...
  MaxClientsHandlerCli: apply: successful
  ```

###### delete

  ```shell
  $ max_clients_handler_cli -m delete -k /path/to/hoge.php
  MaxClientsHandlerCli: delete: successful
  MaxClientsHandlerCli: apply: successful
  ```

###### apply

  ```shell
  $ max_clients_handler_cli -m apply
  MaxClientsHandlerCli: apply: successful
  ```

### Tests

##### Unit test

  - Coming Soon

##### Binary test

  - Coming Soon
