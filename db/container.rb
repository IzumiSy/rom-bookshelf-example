class InfrastructureContainer
  extend Dry::Container::Mixin

  register "db_adapter" do
    config = ROM::Configuration.new(:sql, "sqlite://app.db")
    config.auto_registration("./relations")
    config.auto_registration("./commands")
    container = ROM.container(config)
    container
  end
end

Import = Dry::AutoInject(InfrastructureContainer)
