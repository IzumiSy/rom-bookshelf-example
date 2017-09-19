class InfrastructureContainer
  extend Dry::Container::Mixin

  register "db_adapter" do
    ROM.container(:sql, "sqlite://app.db") do |config|
      config.relation(:authors) do
        schema(infer: true) do
          associations do
            has_many :books
          end
        end
      end

      config.relation(:shelves) do
        schema(infer: true) do
          associations do
            has_many :books
          end
        end
      end

      config.relation(:books) do
        schema(infer: true) do
          associations do
            belongs_to :author
            belongs_to :shelf
          end
        end
      end
    end
  end
end

Import = Dry::AutoInject(InfrastructureContainer)
