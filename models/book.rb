module Domain
  class Book
    attr_reader :id, :title, :price, :author

    def initialize(attrs)
      @id, @title, @price, @author = attrs.values_at(:id, :title, :price, :author)
    end
  end
end
