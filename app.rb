require "sinatra/base"
require "rom-repository"
require "dry-auto_inject"
require "jsonapi-serializers"
require "pry" if ENV["RACK_ENV"] === "development"
require_relative "container"
require_relative "controllers/books_controller"
require_relative "controllers/authors_controller"

class App < Sinatra::Base
  use BooksController
  use AuthorsController
end
