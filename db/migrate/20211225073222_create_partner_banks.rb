class CreatePartnerBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :partner_banks, id: :uuid do |t|
      t.references :partner, null: false, foreign_key: true, type: :uuid
      t.references :bank,    null: false, foreign_key: true, type: :uuid
      t.string     :account
      t.string     :comment
      t.integer    :status,  null: false, default: 0, limit: 1  # default: 'active'

      t.timestamps
    end
  end
end
