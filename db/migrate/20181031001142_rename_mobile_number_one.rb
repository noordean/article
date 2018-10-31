class RenameMobileNumberOne < ActiveRecord::Migration[5.2]
  def change
    rename_column :submissions, :mobile_number_one, :phone_number
  end
end
