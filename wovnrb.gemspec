lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wovnrb/version'

Gem::Specification.new do |spec|
  spec.name          = 'wovnrb'
  spec.version       = Wovnrb::VERSION
  spec.authors       = ['Jeff Sandford', 'Antoine David']
  spec.email         = ['jeff@wovn.io']
  spec.summary       = 'Gem for WOVN.io'
  spec.description   = 'Ruby gem for WOVN backend on Rack.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  files = `git ls-files -z`.split("\x0")
  files.delete('BEFORE_PUSHING')
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'addressable'
  spec.add_dependency 'lz4-ruby'
  spec.add_dependency 'nokogiri', '~> 1.8.1'
  spec.add_dependency 'nokogumbo', '>= 1.4.0', '< 2.0.0'
  spec.add_dependency 'rack'

  spec.add_development_dependency 'bundler', '>= 1.7'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'listen', '~> 3.0.6'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rb-readline'
  spec.add_development_dependency 'shoulda-context'
  spec.add_development_dependency 'terminal-notifier'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'test-unit-notify'

  spec.add_development_dependency 'rake-compiler'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'timecop'

  # NOTE; it need to use webmock 2.3.2 for avoiding error when we use ruby 2.4.x.
  # https://github.com/bblimke/webmock/issues/683
  spec.add_development_dependency 'public_suffix', '~> 1.4.6'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '>= 2.3.2'
end
