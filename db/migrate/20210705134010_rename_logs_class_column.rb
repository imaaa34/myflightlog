class RenameLogsClassColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :logs, :class, :boarded_class
  end
end
