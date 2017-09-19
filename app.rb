require "sinatra/base"
require "rom-repository"
require "dry-auto_inject"
require "jsonapi-serializers"
require "pry" if ENV["RACK_ENV"] === "development"
require_relative "db/container"
require_relative "repositories/author_repository"
require_relative "repositories/book_repository"
require_relative "serializers/base_serializer"
require_relative "serializers/book_serializer"

class App < Sinatra::Base
  get "/" do
    authorRepo = Repository::Author.new
    bookRepo = Repository::Book.new

    # id: 1
    author_changeset = authorRepo
      .changeset(name: "Jonathan")
      .map(:add_timestamps)
    author = authorRepo.create(author_changeset)

    # id: 1
    book_changeset = bookRepo
      .changeset(title: "Jonathan's book 1", price: 500)
      .map(:add_timestamps)
      .associate(author)
    bookRepo.create(book_changeset)

    # id: 2
    book_changeset = bookRepo
      .changeset(title: "Jonathan's book 2", price: 1000)
      .map(:add_timestamps)
      .associate(author)
    bookRepo.create(book_changeset)

    book = bookRepo.by_id_with_author(1)

    content_type :json
    body JSONAPI::Serializer.serialize(book).to_json
  end
end
