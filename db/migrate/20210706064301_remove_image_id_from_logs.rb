class RemoveImageIdFromLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :logs, :image_id, :integer
  end
end
