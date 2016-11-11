MRuby::Gem::Specification.new('max_clients_handler_cli') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MRuby Developer'
  spec.summary = 'max_clients_handler_cli'
  spec.bins    = ['max_clients_handler_cli']

  spec.add_dependency 'mruby-print',         :core => 'mruby-print'
  spec.add_dependency 'mruby-mtest',         :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-dir',           :mgem => 'mruby-dir'
  spec.add_dependency 'mruby-io',            :mgem => 'mruby-io'
  spec.add_dependency 'mruby-getopts',       :mgem => 'mruby-getopts'
  spec.add_dependency 'mruby-yaml',          :mgem => 'mruby-yaml'
  spec.add_dependency 'mruby-cache',         :mgem => 'mruby-localmemcache'
  spec.add_dependency 'mruby-iijson',        :mgem => 'mruby-iijson'
  spec.add_dependency 'mruby-env',           :mgem => 'mruby-env'
end
