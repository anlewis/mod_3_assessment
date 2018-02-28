class Api::V1::PlaysController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    word = params[:word]

    if OxfordService.new.validate_word(word)
      Play.create(user_id: params[:user_id],
                  game: Game.find(params[:game_id]),
                  word: word
                 )
      render json: {message: "you've played the word: #{word}!"}.to_json
    else
      render json: {message: "#{word} is not a valid word."}.to_json
    end
  end
end