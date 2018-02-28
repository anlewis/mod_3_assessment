class GameSerializer < ActiveModel::Serializer
  attributes :id, :scores

  def scores
    user_scores = object.plays.group(:user_id).sum(:score)
    user_scores.to_a.map { |user_id, score| { user_id: user_id, score: score } }
  end
end
