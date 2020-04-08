# json.array! @posts, partial: "posts/post", as: :post
# hash = { author: { name: "David" } }

json.array! @posts do |post|
	# json.id post.id
	# json.title post.title

	json.extract post, :id ,:title , :body ,:image
	json.created_At l(post.created_at , format: :short)
	json.url post_url(post , format: :json)
	
end