class QuestionPolicy < ApplicationPolicy

  def subscribe?
    @user #not nil
  end


end
