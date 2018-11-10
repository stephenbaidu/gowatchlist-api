json.extract! watchlist, :id, :name, :url, :selector, :active
json.extract! watchlist, :expires_at, :created_at, :updated_at

if watchlist.visit_info
  json.extract! watchlist.visit_info, :visits, :alerts
end
