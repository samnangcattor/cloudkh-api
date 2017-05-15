class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :google_file
      t.integer :mime_type
      t.integer :status

      t.references :user, index: true
      t.timestamps
    end
  end
end
