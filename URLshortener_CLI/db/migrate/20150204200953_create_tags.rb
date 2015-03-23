class CreateTags < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :name
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :shortened_url_id
      t.integer :tag_id
    end

    add_index :taggings, :shortened_url_id
    add_index :taggings, :tag_id
  end


end
