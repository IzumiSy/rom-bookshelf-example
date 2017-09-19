class BookSerializer
  include JSONAPI::Serializer

  attribute :id, :title, :price

  attribute :author_name do
    object.author.name
  end
end
