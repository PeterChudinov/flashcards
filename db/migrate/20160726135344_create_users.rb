class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password

      t.timestamps null: false
    end

    change_table :cards do |t|
      t.belongs_to :user, index: true
    end
  end
end
