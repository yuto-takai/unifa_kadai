class CreatePostedPhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :posted_photos do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.timestamps
    end
  end
end
