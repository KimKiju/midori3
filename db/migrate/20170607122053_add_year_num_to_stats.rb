class AddYearNumToStats < ActiveRecord::Migration
  def change
        add_column :stats, :year_num, :integer
  end
end
