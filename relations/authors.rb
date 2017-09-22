module Relation
  class Authors < ROM::Relation[:sql]
    schema(infer: true) do
      associations do
        has_many :books
      end
    end

    def with_books
      join(:books)
    end
  end
end
