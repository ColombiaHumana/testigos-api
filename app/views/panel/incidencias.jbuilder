
json.array! Issue.all.each do |issue|
  json.name issue.name
  json.y issue.reports.count
end
