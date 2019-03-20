class ChangeVideosTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :videos, :video_id
  end
end
