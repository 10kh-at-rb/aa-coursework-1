class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.integer :post_id, nil: false
      t.integer :sub_id, nil: false

      t.timestamps
    end
  end
end
