# Create users
puts "Start Creating 50 users"
users = []
50.times do |n|
  users << User.create(username: "user#{n+1}")
end
puts "Creating 50 users successfully"
puts "-----------------------------"

puts "Start creating 50000 posts"
# Create posts
posts_attributes = []
50_000.times do |n|
  user = users.sample
  posts_attributes << { title: "Post #{n+1}", body: "Body of Post #{n+1}", user: user }
end
Post.create!(posts_attributes)
puts "Creating 50000 posts successfully"
puts "-----------------------------"

puts "Start creating 20_000 reviews"
# Create reviews
reviews_attributes = []
20_000.times do |n|
  post = Post.offset(rand(Post.count)).first
  user = users.sample
  reviews_attributes << { rating: rand(1..5), comment: "Review #{n+1}", post: post, user: user }
end
Review.create!(reviews_attributes)
puts "Creating 2000 reviews successfully"
puts "-----------------------------"
