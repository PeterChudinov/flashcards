require_relative '20160726135344_create_users'

class SorceryCore < ActiveRecord::Migration
  def change
    revert CreateUsers

    create_table :users do |t|
      t.string :email, :null => false
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end

    add_index :users, :email, unique: true

    change_table :cards do |t|
      t.belongs_to :user, index: true
    end
  end
end
