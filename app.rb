require "sinatra/base"
require "rom-repository"
require "dry-auto_inject"
require "pry" if ENV["RACK_ENV"] === "development"
require_relative "repositories/container"

Repositories = Dry::AutoInject(RepositoryContainer)

class App < Sinatra::Base
  include Repositories[
    BookRepo: "book",
    AuthorRepo: "author"
  ]

  get "/" do
    # id: 1
    author_changeset = self.AuthorRepo
      .changeset(name: "Jonathan")
      .map(:add_timestamps)
    author = self.AuthorRepo.create(author_changeset)

    # id: 1
    book_changeset = self.BookRepo
      .changeset(title: "Jonathan's book 1", price: 500)
      .map(:add_timestamps)
      .associate(author)
    self.BookRepo.create(book_changeset)

    # id: 2
    book_changeset = self.BookRepo
      .changeset(title: "Jonathan's book 2", price: 1000)
      .map(:add_timestamps)
      .associate(author)
    self.BookRepo.create(book_changeset)

    result = self.BookRepo.by_id_with_author(1)

    # binding.pry

    body "hello"
  end
end
