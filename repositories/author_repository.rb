require "dry-auto_inject"
require_relative "../db/container"
require_relative "../models/author"

Import = Dry::AutoInject(InfrastructureContainer)

module Repository
  class Author < ROM::Repository[:authors]
    include Import["db_adapter"]

    relations :books
    commands :create, update: :by_pk

    def initialize(_args)
      super(_args[:db_adapter])
    end

    def query(conditions)
      authors.where(conditions).map_to(Domain::Author)
    end

    def all
      authors.map_to(Domain::Author)
    end
  end
end
