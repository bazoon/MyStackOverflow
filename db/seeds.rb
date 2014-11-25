# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

USER_COUNT = 10
QUESTION_COUNT = 40
ANSWERS_COUNT = 600
COMMENTS_COUNT = 20

USER_COUNT.times do 
  user_params = {}
  user_params[:email] = Faker::Internet.email
  user_params[:password] = Faker::Internet.password
  user_params[:password_confirmation] = user_params[:password]
  user_params[:name] = Faker::Name.name
  user_params[:rating] = rand(32)

  user = User.new(user_params)
  user.skip_confirmation!
  user.save!
end

QUESTION_COUNT.times do

  user = User.all.sample
  question = user.questions.create(
      title: Faker::Lorem.sentence(3, true, 4),
      body: Faker::Lorem.sentence(12, true, 4),
      tag_tokens: Faker::Lorem.words(3).join(','),
      impressions_count: rand(100),
      rating: rand(20)
    )
  rand(COMMENTS_COUNT).times do
    question.comments.create!(body: Faker::Lorem.sentence(14), user: User.all.sample)
  end

end


ANSWERS_COUNT.times do

  question = Question.all.sample
  answer = question.answers.create!(body: Faker::Lorem.sentence(20), 
                                    user: User.all.sample,
                                    rating: rand(20))

  rand(COMMENTS_COUNT).times do
    answer.comments.create!(body: Faker::Lorem.sentence(14), user: User.all.sample)
  end

end










