class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name

      t.timestamps null: false
    end

    change_table :cards do |t|
      t.belongs_to :deck, null: false
    end
  end
end
