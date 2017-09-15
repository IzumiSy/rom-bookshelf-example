require_relative "../db/container"
require_relative "author_repository"
require_relative "book_repository"

Infrastructure = Dry::AutoInject(InfrastructureContainer)

class RepositoryContainer
  extend Dry::Container::Mixin
  include Infrastructure["sqlite_adapter"]

  register "book" do
    Repository::Book.new(self.new.sqlite_adapter)
  end

  register "author" do
    Repository::Author.new(self.new.sqlite_adapter)
  end
end
