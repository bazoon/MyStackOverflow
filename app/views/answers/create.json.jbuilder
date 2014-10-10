json.answer @answer, :id, :body, :question_id
json.created_at l(@answer.created_at)
json.user_name @answer.user.name
json.user_eamil @answer.user.email

json.edit_path edit_answer_path(@answer)
json.destroy_path answer_path(@answer)
json.select_path select_answer_path(@answer)
json.selected @answer.selected 

json.attachments @answer.attachments do |attach|
  json.id attach.id
  json.file_name attach.file.identifier
  json.file_url attach.file.url
end

