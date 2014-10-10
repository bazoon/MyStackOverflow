json.answer @answer, :id, :body, :question_id

json.attachments @answer.attachments do |attach|
  json.id attach.id
  json.file_name attach.file.identifier
  json.file_url attach.file.url
end

