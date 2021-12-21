class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks, id: :uuid do |t|
      t.string  :name,          null: false, index: { unique: true }
      t.string  :title,         null: false, index: { unique: true }
      t.string  :brief_title
      t.string  :legal_address
      t.string  :postal_address
      t.string  :phone
      t.string  :email,         null: false, index: { unique: true }
      t.string  :url
      t.string  :corr_acc,      null: false, index: { unique: true }
      t.string  :corr_acc_with, null: false
      t.string  :bic,           null: false, index: { unique: true }
      t.string  :inn,           null: false, index: { unique: true }
      t.string  :kpp
      t.string  :ogrn
      t.string  :okpo
      t.string  :okato
      t.string  :comment
      t.integer :status,        null: false, default: 0, limit: 1  # default: 'active'

      t.timestamps
    end
  end
end
