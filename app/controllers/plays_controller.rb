class PlaysController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] 

  def create
    word = params[:word]
    root = OxfordService.new.make_play(word)

    if root
      Play.create(word: params[:word])
      flash[:success] = "'#{word}' is a valid word and its root form is '#{root}'."
    else
      flash[:error] = "'#{word}' is not a valid word."
    end

    redirect_to root_url
  end
end