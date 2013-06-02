class CreateSavings < ActiveRecord::Migration
  def change
    create_table :savings do |t|
      t.date :date
      t.integer :price

      t.timestamps
    end
  end
end
