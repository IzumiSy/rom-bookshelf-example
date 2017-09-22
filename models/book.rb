module Domain
  class Book
    attr_reader :id, :title, :price

    def initialize(attrs)
      @id, @title, @price = attrs.values_at(:id, :title, :price)
    end
  end
end
