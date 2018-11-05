json.array!(@watchlists) do |watchlist|
  json.partial! 'show', locals: { watchlist: watchlist }
end