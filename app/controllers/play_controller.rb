class PlayController < ApplicationController
  def create
    word = params[:word]

    @conn = Faraday.new(url: "https://od-api.oxforddictionaries.com/api/v1") do |faraday|
      faraday.headers["app_id"] = ENV["oxford_app_id"]
      faraday.headers["app_key"] = ENV["oxford_app_key"]
      faraday.headers["Accept"] = "application/json"
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("inflections/en/#{word}")

    if response.status == 404
      flash[:success] = "#{word} is not a valid word."
    else
      root = JSON.parse(response.body, symbolize_names: true)[:results]
        .first[:lexicalEntries]
        .first[:inflectionOf]
        .first[:text]
      Play.create(word: params[:word])
      flash[:success] = "#{word} is a valid word and its root form is #{root}."
    end
  end
end