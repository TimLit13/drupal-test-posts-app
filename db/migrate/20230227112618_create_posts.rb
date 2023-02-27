class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.string :description, null: false, default: ""
      t.text :body, null: false, default: ""
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, :title, unique: true
  end
end
