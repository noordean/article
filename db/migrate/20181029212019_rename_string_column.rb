class RenameStringColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :submissions, :string, :date_of_birth
    change_column :submissions, :date_of_birth, :string
  end
end
