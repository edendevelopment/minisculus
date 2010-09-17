require 'rubygems'
require 'sinatra'
require 'json'

set :environment, :test

get '/start' do
  redirect first_question_path, 303
end

get '/you-have-finished' do
  return_json :finished => true
end

get '/:key' do
  return_json :question => question(params[:key])
end

put '/:key' do
  if correct_answer?(params[:key]) 
    redirect next_question_path(params[:key]), 303
  else
    halt 406
  end
end

helpers do
  def question(key)
    question = find_question(key)
    question[:question] if question
  end

  def answer(key)
    question = find_question(key)
    question[:answer] if question
  end

  def index(key)
    questions.index(find_question(key))
  end

  def find_question(key)
    questions.find { |q| q[:key] == key }
  end

  def first_question_path
    "/#{questions.first[:key]}"
  end

  def next_question_path(key)
    if next_question(key)
      "/#{next_question(key)[:key]}"
    else
      "/you-have-finished"
    end
  end
  
  def next_question(key)
    next_question = questions[index(key) + 1]
  end

  def questions
    settings.questions
  end

  def return_json(data)
    content_type 'application/json'
    data.to_json
  end
  
  def correct_answer?(key)
    answer(params[:key]) == user_answer
  end

  def user_answer
    JSON.parse(request.env["rack.input"].read, :symbolize_names => true)[:answer]
  end
end
