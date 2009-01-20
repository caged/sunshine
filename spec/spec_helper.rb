begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

Spec::Runner.configure do |config|
  def fixture(filename)
    JSON.parse(IO.read(File.join(File.dirname(__FILE__), 'fixtures', "#{filename}.json")))
  end
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'sunshine'

dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
Sunshine.api_key = File.read(File.join(dir, '..', '.sunlight_api_key'))