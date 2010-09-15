require 'spec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'minisculus')
require 'rack/test'

set :environment, :test

describe 'minisculus' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'sends out ciphered text' do
    get '/'
    last_response.should be_ok
    last_response.body.should_not be_empty
  end

end
