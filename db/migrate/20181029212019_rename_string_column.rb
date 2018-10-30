class RenameStringColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :submissions, :date_of_birth, :string
  end
end
