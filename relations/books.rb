class Books < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      belongs_to :author
      belongs_to :shelf
    end
  end

  def by_id(id)
    where(id: id)
  end

  def available
    where(is_available: true)
  end
end
