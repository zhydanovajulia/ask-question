class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :user_id
    	t.integer :answer_id
    	t.string :body
      t.timestamps
    end
  end
end
