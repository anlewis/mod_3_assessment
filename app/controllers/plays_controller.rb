class PlaysController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] 

  def create
    word = params[:word]

    # extract into service poro
    @conn = Faraday.new(url: "https://od-api.oxforddictionaries.com/api/v1") do |faraday|
      faraday.headers["app_id"] = ENV["oxford_app_id"]
      faraday.headers["app_key"] = ENV["oxford_app_key"]
      faraday.headers["Accept"] = "application/json"
      faraday.adapter Faraday.default_adapter
    end

    response = @conn.get("inflections/en/#{word}")

    if valid_word?(response)
      root = find_root(response)
      Play.create(word: params[:word])
      flash[:success] = "'#{word}' is a valid word and its root form is '#{root}'."
    else
      flash[:error] = "'#{word}' is not a valid word."
    end

    redirect_to root_url
  end

  private

    def valid_word?(response)
      response.status == 200
    end

    def find_root(response)
      JSON.parse(response.body, symbolize_names: true)[:results]
        .first[:lexicalEntries]
        .first[:inflectionOf]
        .first[:text]
    end
end