class AddLogIdToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :log_id, :integer
  end
end
