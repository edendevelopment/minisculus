Before('@simple_questions') do
  set :questions, [
    {:key => 'foo', :question => '1+1', :answer => '2'},
    {:key => 'bar', :question => '1x3', :answer => '3'},
  ]
end
