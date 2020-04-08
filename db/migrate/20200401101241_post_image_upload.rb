class PostImageUpload < ActiveRecord::Migration[6.0]
  def up
  	add_column('posts','image',:string)
  end


  def down
  	remove_column('posts','image')
  end
end
