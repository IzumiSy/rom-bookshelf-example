class Books < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      belongs_to :author
      belongs_to :shelf
    end
  end

  def ids
    select(:id)
  end

  def index
    select(:id, :title, :price)
  end

  def index_with_timestamps
    index.select_append(:created_at, :updated_at)
  end
end
