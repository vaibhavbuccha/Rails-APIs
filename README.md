# README



## Add Kaminari for pagination

some basic queries for pagination
```rb
# get records according to pages
 Post.page(page_no) 
# default limit is 11 and offset is 25

post = Post.page(2).per(5)

# per is used for set per page counts of posts

Post.count # it will show the total count of posts

post.total_count  # it will show the total count of posts
post.total_pages # it will show the total pages of posts

post.next_page  # it will give the next page count
post.current_page # it will give the current page number
post.prev_page  # it will give the previous page number
post.last_page? # it tails that current page is last page or not 
post.first_page? # it will tails that trhe current page is first page or not

```



