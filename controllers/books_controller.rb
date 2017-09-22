require_relative "../repositories/book_repository"
require_relative "../serializers/author_serializer"

class BooksController < Sinatra::Base
  before do
    content_type :json
  end

  post "/books" do
    title = params[:title]
    price = params[:price]
    author_id = params[:author_id]

    bookRepo = Repository::Book.new

    book_changeset = bookRepo
      .changeset(title: title, price: price)
      .map(:add_timestamps)
      .associate(author)
    bookRepo.create(book_changeset)

    status :created
  end

  get "/books" do
    bookRepo = Repository::Book.new

    books = bookRepo.all.to_a

    body JSONAPI::Serializer
      .serialize(books, is_collection: true)
      .to_json
  end
end
