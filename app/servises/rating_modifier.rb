class RatingModifier
  
  def initialize(voter)
    @voter = voter
  end

  def cant_vote?(object)
    object.user == @voter || Vote.voted?(object, @voter)
  end

  # SOLID

  def vote_up(object)
    return if cant_vote?(object)
    Vote.up(object, @voter)
    object.vote_up(@voter)
  end

  def vote_down(object)
    return if cant_vote?(object)
    Vote.down(object, @voter)
    object.vote_down(@voter)
    @voter.down_by(1)
  end

  def accept(answer)
    return if answer.user == @voter
    answer.set_as_selected
    answer.user.up_by(Answer::ACCEPT_WEIGHT)
  end


end