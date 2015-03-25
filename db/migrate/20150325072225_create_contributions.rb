class CreateContributions < ActiveRecord::Migration
  def change
      create_table :contributions do |t|
          t.string :name
          t.text :body
          t.string :img
          
          t.timestamps
        end
  end
end