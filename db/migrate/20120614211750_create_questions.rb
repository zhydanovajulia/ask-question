class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user
    	t.text :subject, :null => false
      t.text :description
    	t.integer :watch_count, :default => 0
      t.timestamps
    end
  end
end
