class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.string :quality, null: false
      t.float :price, null: false
      t.integer :purchasable_id, null: false
      t.string :purchasable_type, null: false
      t.datetime :begin_at, null: false
      t.datetime :end_at, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
