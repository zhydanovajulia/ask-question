class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.references :user
    	t.references :question
    	t.text :body, :null => false
      t.timestamps
    end
  end
end
