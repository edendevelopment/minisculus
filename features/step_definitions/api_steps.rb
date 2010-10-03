require 'json'

def each_header(headers)
  headers.split("\n").each do |header|
    key, value = header.split(': ', 2)
    yield(key, value)
  end
end

Given /^the quiz is configured with the questions:$/ do |json_data|
  set :questions, JSON.parse(json_data, :symbolize_names => true)
end

Given /^the quiz has the ending:$/ do |json_data|
  set :ending, JSON.parse(json_data, :symbolize_names => true)
end

Given /^I have the answer data$/ do |data|
  @answer_data = data
end

When /^I PUT (.+) with request headers:$/ do |path, headers|
  each_header(headers) { |key, value| header(key, value) }
  put path, @answer_data
end

When /^I GET (.+) with request headers:$/ do |path, headers|
  each_header(headers) { |key, value| header(key, value) }
  get path
end

Then /^the headers should contain:$/ do |headers|
  each_header(headers) { |key, value| last_response.headers[key].should == value }
end

Then /^the status should be (\d+)$/ do |status|
  last_response.status.should == status.to_i
end

Then /^the body should contain JSON:$/ do |data|
  last_response.headers["Content-Type"].should == "application/json"
  JSON.parse(last_response.body).should == JSON.parse(data)
end

Then /^the body should contain:$/ do |text|
  last_response.body.should be_include(text)
end
