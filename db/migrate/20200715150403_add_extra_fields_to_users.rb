class AddExtraFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :gender, :string
    add_column :users, :location, :text
    add_column :users, :dob, :date
    add_column :users, :bio, :text
    add_column :users, :image, :text
  end
end
