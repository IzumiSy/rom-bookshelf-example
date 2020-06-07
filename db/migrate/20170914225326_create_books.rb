ROM::SQL.migration do
  change do
    create_table :books do
      primary_key :id
      foreign_key :author_id, :authors, null: false
      foreign_key :shelf_id, :shelves
      column :title, String, null: false
      column :price, Integer, null: false
      column :is_available, TrueClass, null: false, default: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      index [:author_id], name: :author_id
      index [:shelf_id], name: :shelf_id
    end
  end
end
