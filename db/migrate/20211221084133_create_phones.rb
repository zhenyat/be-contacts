class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones, id: :uuid do |t|
      t.string  :number, null: false, index: { unique: true }
      t.integer :kind,   null: false, default: 0, limit: 1  # default: 'mobile'
      t.integer :status, null: false, default: 0, limit: 1  # default: 'active'

      t.timestamps
    end
  end
end
