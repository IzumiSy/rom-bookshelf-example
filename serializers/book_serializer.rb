require_relative "base_serializer"

module Domain
  class BookSerializer < Domain::BaseSerializer
    attributes :id, :title, :price

    attribute :author_name do
      object.author[:name]
    end
  end
end
