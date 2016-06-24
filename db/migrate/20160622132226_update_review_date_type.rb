class UpdateReviewDateType < ActiveRecord::Migration
  def change
    remove_column :cards, :review_date
    add_column :cards, :review_date, :date
  end
end
