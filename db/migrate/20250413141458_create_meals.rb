class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.references :diet_plan, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
