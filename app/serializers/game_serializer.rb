class GameSerializer < ActiveModel::Serializer
  attributes :id, :scores

  def scores
    user_scores = object.plays.group(:user_id).sum(:score)
    scores = []
    user_scores.each do |user_id, score|
      scores << {"user_id":user_id, "score":score}
    end
    scores
  end
end
