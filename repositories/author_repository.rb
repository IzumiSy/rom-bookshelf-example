require_relative "../models/author"

module Repository
  class Author < ROM::Repository[:authors]
    include Import["db_adapter"]

    relations :books
    commands :create, update: :by_pk

    def initialize(_args)
      super(_args[:db_adapter])
    end

    def by_id(id)
      authors.by_pk(id).one
    end

    def by_id_with_books(id)
      authors
        .by_pk(id)
        .aggregates(:books)
        .map_to(Domain::Author)
        .one
    end

    def query(conditions)
      authors
        .with_books
        .where(conditions)
        .map_to(Domain::Author)
    end

    def all
      authors
        .with_books
        .map_to(Domain::Author)
    end
  end
end
