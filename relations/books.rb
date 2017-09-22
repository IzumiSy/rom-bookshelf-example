class Books < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      belongs_to :author
      belongs_to :shelf
    end
  end

  def with_author_id(author_id)
    where(author_id: author_id)
  end
end
