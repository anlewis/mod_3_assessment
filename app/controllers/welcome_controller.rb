class WelcomeController < ApplicationController
  def index
    @word = Word.new
    # @conn = Faraday.new(url: "https://od-api.oxforddictionaries.com/api/v1") do |faraday|
    #   faraday.headers["app_id"] = ENV["oxford_app_id"]
    #   faraday.headers["app_key"] = ENV["oxford_app_key"]
    #   faraday.headers["Accept"] = "application/json"
    #   faraday.adapter Faraday.default_adapter
    # end

    # response = @conn.get("entries/en/ace/synonyms")

    # @synonyms = JSON.parse(response.body, symbolize_names: true)
  end
end
