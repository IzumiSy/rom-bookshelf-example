require_relative "base_serializer"

module Domain
  class AuthorSerializer < Domain::BaseSerializer
    has_many :books, include_links: false

    attributes :id, :name
  end
end
