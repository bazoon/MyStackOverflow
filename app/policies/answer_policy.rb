class AnswerPolicy < ApplicationPolicy

  def select?
    @user && @record.question.user == @user || @user && @user.admin
  end

end
