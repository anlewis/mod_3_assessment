class Api::V1::PlaysController < ApplicationController
  def create
    word = params[:play][:word]

    OxfordService.new.validate_word(word)



    play = Play.new(user_id: params[:play][:user_id],
                game: Game.find(params[:game_id]),
                word: params[:play][:word]
               )
    if play.save
      render json: {status: 201}.to_json
    else
      render json: {message: "foxez is not a valid word."}.to_json
    end
  end
end