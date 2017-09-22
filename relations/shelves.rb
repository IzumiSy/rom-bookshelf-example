class Shelves < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      has_many :books
    end
  end
end
