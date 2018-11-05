module GowatchlistApi
  module ResponseHelper
    def response_json
      JSON.parse(response.body) rescue {}
    end
  end
end

RSpec.configure do |config|
  config.include GowatchlistApi::ResponseHelper
end
