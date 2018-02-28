class OxfordService
  def initialize
    @conn = Faraday.new(url: "https://od-api.oxforddictionaries.com/api/v1") do |faraday|
      faraday.headers["app_id"] = ENV["oxford_app_id"]
      faraday.headers["app_key"] = ENV["oxford_app_key"]
      faraday.headers["Accept"] = "application/json"
      faraday.adapter Faraday.default_adapter
    end
  end

  def make_play(word)
    find_root(word_response(word)) if validate_word(word)
  end

  def validate_word(word)
    valid_word?(word_response(word))
  end

  private
    attr_reader :conn

    def valid_word?(response)
      response.status == 200
    end

    def word_response(word)
      @conn.get("inflections/en/#{word}")
    end

    def find_root(response)
      JSON.parse(response.body, symbolize_names: true)[:results]
        .first[:lexicalEntries]
        .first[:inflectionOf]
        .first[:text]
    end
end