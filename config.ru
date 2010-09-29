# encoding: UTF-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'minisculus'

require 'json'

set :run, false
set :environment, :production
set :root, File.dirname(__FILE__)

set :questions, JSON.parse(File.read('questions.json'), :symbolize_names => true)
set :ending, {:email => 'minisculus@edendevelopment.co.uk', :code => '1234567890', :key => 'you-did-it', :'reference-url' => 'you-did-it.html'}

run Sinatra::Application
