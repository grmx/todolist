class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.timestamps null: false
      t.references :user, index: true, foreign_key: true
      t.string :title, null: false
      t.integer :priority
    end
  end
end
