class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.integer :user_id
    	t.string :subject
      t.string :description
    	t.integer :rate
    	t.integer :answers_count
    	t.integer :wath_count
      t.timestamps
    end
  end
end
