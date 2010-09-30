# encoding: UTF-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'minisculus'

require 'json'

set :run, false
set :environment, :production
set :root, File.dirname(__FILE__)

data = JSON.parse(File.read('questions.json'), :symbolize_names => true)

set :questions, data[:questions]
set :ending, data[:ending]

run Sinatra::Application
