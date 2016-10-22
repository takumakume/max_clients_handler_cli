MRuby::Gem::Specification.new('max_clients_handler_cli') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MRuby Developer'
  spec.summary = 'max_clients_handler_cli'
  spec.bins    = ['max_clients_handler_cli']

  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
end
