ENV['APP_ENV'] = 'test'

require_relative '../app.rb'
require 'test/unit'
require 'rack/test'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    App
  end

  def test_books
    get '/books'
    assert last_response.ok?
  end

  def test_authors
    get '/authors'
    assert last_response.ok?
  end
end
