class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.integer :author
    	t.string :body
    	t.integer :rate
      t.timestamps
    end
  end
end
