require 'rails_helper'

describe "Plays API" do
  it "can create a new play" do
    josh = User.create(id: 1, name: "Josh")
    sal = User.create(id: 2, name: "Sal")

    game = Game.create(player_1: josh, player_2: sal)

    josh.plays.create(game: game, word: "sal", score: 3)
    josh.plays.create(game: game, word: "zoo", score: 12)
    sal.plays.create(game: game, word: "josh", score: 14)
    sal.plays.create(game: game, word: "no", score: 2)

    play_params = { user_id: 1, word: "at" }

    post "/api/v1/games/#{game.id}/plays", params: { play: play_params }
    play = Play.last

    expect(response).to be_success
    expect(play.word).to eq play_params[:word]

    get "/api/v1/games/#{game.id}"

    game_response = JSON.parse(response.body)

    expect(game_response["scores"].first["user_id"]).to eq 1
    expect(game_response["scores"].first["score"]).to eq 17
  end

  it "can't create a new play for an invalid word'" do
    josh = User.create(id: 1, name: "Josh")
    sal = User.create(id: 2, name: "Sal")

    game = Game.create(player_1: josh, player_2: sal)

    josh.plays.create(game: game, word: "sal", score: 3)
    josh.plays.create(game: game, word: "zoo", score: 12)
    sal.plays.create(game: game, word: "josh", score: 14)
    sal.plays.create(game: game, word: "no", score: 2)

    play_params = { user_id: 1, word: "foxez" }

    post "/api/v1/games/#{game.id}/plays", params: { play: play_params }

    response_message = JSON.parse(response.body)

    expect(response_message["message"]).to eq "foxez is not a valid word."
  end
end