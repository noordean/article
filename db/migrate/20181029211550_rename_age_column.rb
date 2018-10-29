class RenameAgeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :submissions, :age, :date_of_birth
    rename_column :submissions, :age, :date_of_birth
  end
end
