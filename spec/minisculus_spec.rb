require 'spec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'minisculus')
require 'rack/test'

set :environment, :test

describe 'minisculus' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:cipher) { mock(:cipher, :generate => "THIS IS A MESSAGE") }

  before(:each) do
    set :cipher, cipher
  end

  it 'sends out ciphered text' do
    get '/message'
    last_response.should be_ok
    last_response.body.should == cipher.generate
  end

end
