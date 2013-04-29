class ChangeKarmaSumColumn < ActiveRecord::Migration
  def up
    change_column :users, :karma_sum, :integer, :default => 0
  end

  def down
    change_column :users, :karma_sum, :integer
  end
end
