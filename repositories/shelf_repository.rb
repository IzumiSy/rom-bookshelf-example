module Repository
  class Shelf < ROM::Repository[:shelves]
    include Import["db_adapter"]

    # relations :books
    commands :create

    def initialize(_args)
      super(_args[:db_adapter])
    end
  end
end
