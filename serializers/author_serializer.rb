require_relative "base_serializer"

module Domain
  class AuthorSerializer < Domain::BaseSerializer
    has_many :books

    attributes :id, :name
  end
end
