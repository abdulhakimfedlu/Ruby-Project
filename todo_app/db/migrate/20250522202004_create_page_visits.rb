class CreatePageVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :page_visits do |t|
      t.string :path
      t.integer :total_visits

      t.timestamps
    end
  end
end
