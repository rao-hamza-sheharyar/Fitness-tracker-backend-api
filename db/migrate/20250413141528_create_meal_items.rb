class CreateMealItems < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_items do |t|
      t.references :meal, null: false, foreign_key: true
      t.string :name
      t.integer :calories

      t.timestamps
    end
  end
end
