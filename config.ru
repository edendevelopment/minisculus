# encoding: UTF-8

require 'rubygems'
require './lib/minisculus'
require 'json'

set :run, false
set :environment, :production

set :questions, JSON.parse(File.read('questions.json'), :symbolize_names => true)
set :ending, {:email => 'hello@edendevelopment.co.uk', :code => '1234567890', :key => 'you-did-it'}

run Sinatra::Application
