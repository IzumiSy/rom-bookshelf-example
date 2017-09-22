require_relative "../repositories/author_repository"
require_relative "../serializers/author_serializer"

class AuthorsController < Sinatra::Base
  before do
    content_type :json
  end

  post "/authors" do
    authorRepo = Repository::Author.new

    author_changeset = authorRepo
      .changeset(name: params[:name])
      .map(:add_timestamps)
    authorRepo.create(author_changeset)

    status :created
  end

  get '/authors/:id' do
    authorRepo = Repository::Author.new

    author = authorRepo
      .by_id_with_books(params[:id])

    body JSONAPI::Serializer
      .serialize(author)
      .to_json
  end

  get "/authors" do
    authorRepo = Repository::Author.new

    authors = authorRepo.list.to_a

    body JSONAPI::Serializer
      .serialize(authors, is_collection: true)
      .to_json
  end
end
