class Api::V1::PlaysController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    word = params[:play][:word]

    if OxfordService.new.validate_word(word)
      Play.create(user_id: params[:play][:user_id],
                game: Game.find(params[:game_id]),
                word: params[:play][:word]
               )
    else
      render json: {message: "foxez is not a valid word."}.to_json
    end
  end
end