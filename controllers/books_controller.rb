require_relative "../repositories/book_repository"
require_relative "../repositories/author_repository"
require_relative "../serializers/book_serializer"

class BooksController < Sinatra::Base
  before do
    content_type :json
  end

  post "/books" do
    bookRepo = Repository::Book.new
    authorRepo = Repository::Author.new

    price = params[:price]
    title = params[:title]
    author = authorRepo.by_id(params[:author_id])

    binding.pry
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
