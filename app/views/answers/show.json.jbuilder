json.extract! @answer, :id, :question_id, :body, :created_at, :updated_at
json.user @answer.user, :id, :name
json.update_url  answer_path(@answer)
json.destroy_url answer_path(@answer)

