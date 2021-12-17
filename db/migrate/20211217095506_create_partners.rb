class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners, id: :uuid do |t|
      t.string  :name,   null: false
      t.string  :code,   null: false
      t.string  :title,  null: false
      t.integer :kind,   null: false, default: 3, limit: 1  # default: 'ooo'
      t.integer :role,   null: false, default: 0, limit: 1  # default: 'supplier'
      t.string  :email,  null: false
      t.string  :url
      t.string  :inn,    null: false
      t.string  :kpp
      t.string  :ogrn
      t.string  :ogrnip
      t.string  :okpo
      t.string  :okato
      t.string  :certificate_number
      t.date    :certificate_date
      t.integer :status, null: false, default: 0, limit: 1  # default: 'active'
      t.text    :comment

      t.timestamps
    end
    add_index :partners, :name,  unique: true
    add_index :partners, :code,  unique: true
    add_index :partners, :title, unique: true
    add_index :partners, :email, unique: true
    add_index :partners, :inn,   unique: true
  end
end
