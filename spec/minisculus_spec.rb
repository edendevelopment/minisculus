require 'spec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'minisculus')
require 'rack/test'

set :environment, :test

describe 'minisculus' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

end
