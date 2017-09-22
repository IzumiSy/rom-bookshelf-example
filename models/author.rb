module Domain
  class Author
    attr_reader :id, :name, :books

    def initialize(attrs)
      @id, @name, @books = attrs.values_at(:id, :name, :books)
    end
  end
end
