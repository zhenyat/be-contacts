class CreateAuthorsPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :authors_posts, id: :uuid do |t|
      t.references :author, null: false, foreign_key: true, type: :uuid
      t.references :post, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
