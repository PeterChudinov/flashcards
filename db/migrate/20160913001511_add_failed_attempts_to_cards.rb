class AddFailedAttemptsToCards < ActiveRecord::Migration[5.0]
  def change
    change_table :cards do |t|
      t.integer :failed_attempts_count, limit: 3, null: false, default: 0
    end
  end
end
