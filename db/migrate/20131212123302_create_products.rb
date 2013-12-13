class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, limit: 30
      t.boolean :active, default: false
      t.references :category, index: true

      t.timestamps
    end
  end
end
