require_relative "../repositories/book_repository"
require_relative "../repositories/author_repository"
require_relative "../serializers/book_serializer"

class BooksController < Sinatra::Base
  before do
    content_type :json
  end

  post "/books" do
    bookRepo = Repository::Book.new

    price = params[:price]
    title = params[:title]
    author_id = params[:author_id]

    book_changeset = bookRepo
      .changeset(title: title, price: price, author_id: author_id)
      .map(:add_timestamps)

    bookRepo.create(book_changeset)

    status :created
  end

  get "/books/:id" do
    bookRepo = Repository::Book.new

    book = bookRepo.by_id(params[:id])

    body JSONAPI::Serializer
      .serialize(book)
      .to_json
  end

  get "/books" do
    bookRepo = Repository::Book.new

    books = bookRepo.all.to_a

    body JSONAPI::Serializer
      .serialize(books, is_collection: true)
      .to_json
  end
end
