class AddUserCurrentDeckReference < ActiveRecord::Migration
  def change
    change_table :user do |t|
      t.integer :current_deck_id
    end
  end
end
