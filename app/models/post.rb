class Post < ApplicationRecord
	mount_uploader :image, CoverUploader

	validates :body , presence: true
	validates :title , presence: true

end
