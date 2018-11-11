class CreateDifficultyLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :difficulty_levels do |t|
      t.string :name
      t.integer :number_of_errors

      t.timestamps
    end
  end
end
