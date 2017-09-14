require "sinatra/base"
require "rom-repository"

require "pry" if ENV["RACK_ENV"] === "development"

ROM.container(:sql, "sqlite::memory")

module Domain
  class Book
    attr_reader :id, :title, :price

    def initialize(attrs)
      @id, @title, @price = attrs.values_at(:id, :title, :price)
    end
  end

  class Author
    attr_reader :id, :name

    def initialize(attrs)
      @id, @name = attrs.values_at(:id, :name)
    end
  end
end

module Repo
  class Book < ROM::Repository[:books]
    relations :authors
    commands :create, update: :by_pk

    def query(conditions)
      books.where(conditions).map_to(Domain::Book)
    end

    def by_id_with_author(id)
      books.by_pk(id).wrap_parent(author: authors).one
    end

    def all
      books.map_to(Domain::Book)
    end
  end

  class Author < ROM::Repository[:authors]
    relations :books
    commands :create, update: :by_pk

    def query(conditions)
      authors.where(conditions).map_to(Domain::Author)
    end

    def all
      authors.map_to(Domain::Author)
    end
  end
end

class App < Sinatra::Base
  get "/" do
    rom = ROM.container(:sql, "sqlite::memory") do |config|
      config.default.connection.create_table(:authors) do
        primary_key :id
        column :name, String, null: false
        column :created_at, DateTime, null: false
        column :updated_at, DateTime, null: false
      end

      config.default.connection.create_table(:books) do
        primary_key :id
        foreign_key :author_id, :authors, null: false
        column :title, String, null: false
        column :price, Integer, null: false
        column :created_at, DateTime, null: false
        column :updated_at, DateTime, null: false
      end

      config.relation(:authors) do
        schema(infer: true) do
          associations do
            has_many :books
          end
        end
      end

      config.relation(:books) do
        schema(infer: true) do
          associations do
            belongs_to :author
          end
        end
      end
    end

    bookRepo = Repo::Book.new(rom)
    authorRepo = Repo::Author.new(rom)

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

    result = bookRepo.by_id_with_author(1)

    body "hello"
  end
end
