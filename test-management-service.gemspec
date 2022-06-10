lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/test_management_service/version'

Gem::Specification.new do |spec|
  spec.name    = 'test-management-server'
  spec.version = TestManagementService::VERSION
  spec.authors = ['Alex Moinet']
  spec.email   = ['alex.moinet@smartbear.com']
  spec.required_ruby_version = '>= 2.5.0'
  spec.description = 'A server providing shared functionality to maze-runner ' \
                     'and other platforms testing tools.'
  spec.summary = 'Server providing functionality to support Bugsnag Maze-runner'
  spec.license = 'MIT'
  spec.require_paths = ['lib']
  spec.files = Dir.glob('{lib}/**/*').select { |fn| File.file?(fn) }

  spec.add_dependency 'mongoid', '~> 7.3.0'

  spec.executables = spec.files.grep(%r{^bin/[\w\-]+$}) { |f| File.basename(f) }
end
