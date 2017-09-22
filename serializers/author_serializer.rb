require_relative "base_serializer"

module Domain
  class AuthorSerializer < Domain::BaseSerializer
    attributes :id, :name
  end
end
