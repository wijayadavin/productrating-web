class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      # t.belongs_to :place, null: false, index: true
      t.string :name
      # t.integer :year_created
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
