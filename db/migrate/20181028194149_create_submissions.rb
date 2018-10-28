class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :age
      t.string :class
      t.string :school
      t.text :article
      t.string :email
      t.string :mobile_number_one
      t.string :mobile_number_two

      t.timestamps
    end
  end
end
