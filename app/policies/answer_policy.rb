class AnswerPolicy < ApplicationPolicy

  def select?
    @user && @record.question.user == @user || @user && @user.admin #TODO: скобки

  end

end
