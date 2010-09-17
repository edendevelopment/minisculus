require 'spec/expectations'
require 'rack/test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'minisculus')

require 'capybara/cucumber'
Capybara.app = Sinatra::Application

