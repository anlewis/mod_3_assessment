require 'rails_helper'

describe "Games API" do
  it "returns a single game" do
    josh = User.create(id: 1, name: "Josh")
    sal = User.create(id: 2, name: "Sal")

    game = Game.create(player_1: josh, player_2: sal)

    josh.plays.create(game: game, word: "sal", score: 3)
    josh.plays.create(game: game, word: "zoo", score: 12)
    sal.plays.create(game: game, word: "josh", score: 14)
    sal.plays.create(game: game, word: "no", score: 2)

    get "/api/v1/games/#{game.id}"

    game_response = JSON.parse(response.body)

    expect(response).to be_success
    expect(game_response["id"]).to eq game.id
    expect(game_response["scores"]).to be_an Array
    expect(game_response["scores"].first).to have_key "user_id"
    expect(game_response["scores"].first["user_id"]).to eq 1
    expect(game_response["scores"].first).to have_key "score"
    expect(game_response["scores"].first["score"]).to eq 15
  end
end


    # id = create(:item).id

    # get "/api/v1/items/#{id}"

    # item = JSON.parse(response.body)

    # expect(response).to be_success
    # expect(item["id"]).to eq(id)


#     {
#   "game_id":1,
#   "scores": [
#     {
#       "user_id":1,
#       "score":15
#     },
#     {
#       "user_id":2,
#       "score":16
#     }
#   ]
# }