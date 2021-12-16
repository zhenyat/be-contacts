class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners, id: :uuid do |t|
      t.string  :name,   null: false
      t.string  :code,   null: false
      t.integer :kind,   null: false, default: 3, limit: 1  # default: ООО
      t.integer :role,   null: false, default: 0, limit: 1  # default: supplier
      t.string  :url
      t.integer :status, null: false, default: 0, limit: 1  # default: active
      t.text    :comment

      t.timestamps
    end
    add_index :partners, :name, unique: true
    add_index :partners, :code, unique: true
  end
end
