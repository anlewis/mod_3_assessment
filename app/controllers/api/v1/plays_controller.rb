class Api::V1::PlaysController < ApplicationController
  def create
    Play.create(user_id: params[:play][:user_id],
                game_id: params[:game_id],
                word: params[:play][:word]
               )
    render json: { status: 201 }.to_json
  end
end