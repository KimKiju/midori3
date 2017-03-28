class AddColumnToStat < ActiveRecord::Migration
  def change
    add_column :stats, :night_roll_calling, :string
    add_column :stats, :group_num, :integer
  end
end
