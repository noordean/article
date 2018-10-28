class RenameClassColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :submissions, :class, :candidate_class
  end
end
