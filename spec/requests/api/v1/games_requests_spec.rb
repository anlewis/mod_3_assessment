require 'rails_helper'

describe "Games API" do
  it "returns a single game" do
    game = create(:game)

    visit "/api/v1/games/#{game.id}"
    binding.pry
    game_response = JSON.parse(response.body)

    expect(response).to be_success
    expect(game_response.id).to eq game.id
    expect(game_response["scores"]).to be_an Array
    expect(game_response["scores"].first).to have_key "user_id"
    expect(game_response["scores"].first).to have_key "score"
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