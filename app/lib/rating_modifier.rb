class RatingModifier

  def initialize(voter)
    @voter = voter
  end

  def cant_vote?(object)
    object.user == @voter || Vote.voted?(object, @voter)
  end

  def vote_up(object)
    return if cant_vote?(object)
    object.vote_up(@voter)
    object.user.up_by(object.class::VOTE_WEIGHT)

  end

  def vote_down(object)
    return if cant_vote?(object)
    object.vote_down(@voter)
    object.user.down_by(object.class::VOTE_DOWN_WEIGHT)
    @voter.down_by(1)
  end

  def accept(answer)
    return if answer.user == @voter
    answer.set_as_selected
    answer.user.up_by(Answer::ACCEPT_WEIGHT)
  end


end