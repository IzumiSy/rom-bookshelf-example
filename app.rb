require "sinatra/base"

class App < Sinatra::Base
  get "/" do
    body "hello"
  end
end
