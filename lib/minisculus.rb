require 'rubygems'
require 'sinatra'

get '/message' do
  settings.cipher.generate
end
