require 'rspec/expectations'
require 'rack/test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'minisculus')

World do
  def app
    Sinatra::Application
  end
  include Rack::Test::Methods
end

