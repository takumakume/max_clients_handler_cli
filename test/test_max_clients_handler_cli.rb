module MaxClientsHandlerCli
  module Config
    ENV["MAX_CLIENTS_HANDLER_CLI_CONFIG"] = "test/max_clients_handler_cli.yaml"
  end
end

class TestMaxClientsHandlerCli < MTest::Unit::TestCase

  def setup

  end

  def test_main
    assert_nil __main__(["self"])
  end
end

MTest::Unit.new.run
