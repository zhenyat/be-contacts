class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end