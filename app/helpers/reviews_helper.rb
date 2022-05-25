module ReviewsHelper
  def left_review?(home, reservation)
    reservation.review.nil? && reservation.finished? && Review.left_review?(home, current_user)
  end

end
