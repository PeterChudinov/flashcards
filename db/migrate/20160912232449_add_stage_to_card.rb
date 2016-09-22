class AddStageToCard < ActiveRecord::Migration[5.0]
  def change
    change_table :cards do |t|
      t.integer :stage, limit: 5, null: false, default: 0
    end
  end
end
