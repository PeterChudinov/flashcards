class AddUserCurrentDeckReference < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :current_deck_id
    end

    change_table :decks do |t|
      t.belongs_to :user, null: false
    end
  end
end
