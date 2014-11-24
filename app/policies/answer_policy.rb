class AnswerPolicy < ApplicationPolicy

  def select?

    if @user
      @record.question.user == @user && @record.user != @user
    else
      false
    end

  end

end
