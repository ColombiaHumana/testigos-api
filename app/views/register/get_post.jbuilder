json.array! @posts do |post|
  json.id post.id
  json.name post.name.titleize
end
