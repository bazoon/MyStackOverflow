json.answer @answer, :id, :body, :question_id, :rating
json.created_at l(@answer.created_at)
json.user_name @answer.user.name
json.user_email @answer.user.email

json.edit_path edit_answer_path(@answer)
json.destroy_path answer_path(@answer)
json.select_path select_answer_path(@answer)
json.vote_up_path answer_vote_up_path(@answer)
json.vote_down_path answer_vote_down_path(@answer)
json.can_vote can? :vote, @answer
json.selected @answer.selected 



json.attachments @answer.attachments do |attach|
  json.id attach.id
  json.file_name attach.file.identifier
  json.file_url attach.file.url
end

