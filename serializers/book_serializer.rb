require_relative "base_serializer"

module Domain
  class BookSerializer < Domain::BaseSerializer
    attributes :id, :title, :price
  end
end
