module Relation
  class Books < ROM::Relation[:sql]
    schema(infer: true) do
      associations do
        belongs_to :author
        belongs_to :shelf
      end
    end
  end
end
