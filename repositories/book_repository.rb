require_relative "../models/book"

module Repository
  class Book < ROM::Repository[:books]
    include Import["db_adapter"]

    relations :authors
    relations :shelves
    commands :create, update: :by_pk

    def initialize(_args)
      super(_args[:db_adapter])
    end

    def by_id(id)
      books.by_pk(id).one
    end

    def query(conditions)
      books.where(conditions).map_to(Domain::Book)
    end

    def all
      books.map_to(Domain::Book)
    end
  end
end
