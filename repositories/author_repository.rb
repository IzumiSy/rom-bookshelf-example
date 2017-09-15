require_relative "../models/author"

module Repository
  class Author < ROM::Repository[:authors]
    relations :books
    commands :create, update: :by_pk

    def query(conditions)
      authors.where(conditions).map_to(Domain::Author)
    end

    def all
      authors.map_to(Domain::Author)
    end
  end
end
