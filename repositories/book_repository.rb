require_relative "../models/book"

module Repository
  class Book < ROM::Repository[:books]
    relations :authors
    commands :create, update: :by_pk

    def by_id_with_author(id)
      books
        .by_pk(id)
        .combine(one: { author: authors })
        .map_to(Domain::Book)
        .one
    end

    def query(conditions)
      books.where(conditions).map_to(Domain::Book)
    end

    def all
      books.map_to(Domain::Book)
    end
  end
end
