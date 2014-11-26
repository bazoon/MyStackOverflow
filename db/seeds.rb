# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

USER_COUNT = 60
QUESTION_COUNT = 120
ANSWERS_COUNT = 600
COMMENTS_COUNT = 15
VOTE_COUNT = 400

USER_COUNT.times do 
  user_params = {}
  user_params[:email] = Faker::Internet.email
  user_params[:password] = Faker::Internet.password
  user_params[:password_confirmation] = user_params[:password]
  user_params[:name] = Faker::Internet.user_name
  user_params[:real_name] = Faker::Name.name
  user_params[:website] = Faker::Internet.url
  user_params[:birth_date] = Faker::Date.between(45.years.ago, 16.years.ago)

  # uri = URI('http://api.randomuser.me/')
  # Net::HTTP.get_response(uri).body
  avatar_web =
  rand(2) == 1 ? "http://api.randomuser.me/portraits/thumb/men/#{rand(99)}.jpg" :
                 "http://api.randomuser.me/portraits/thumb/women/#{rand(99)}.jpg" 
  
  user_params[:avatar_web] = avatar_web
  user_params[:rating] = rand(32)

  user = User.new(user_params)
  user.skip_confirmation!
  user.save!
  user.update(created_at: Faker::Date.between(6.years.ago, 2.years.ago))
end

VOTE_COUNT.times do
  
  user = User.all.sample
  vote = Vote.create!(voteable: user, user_id: user.id, vote: rand(-10..30))
  vote.update(created_at: Faker::Date.between(5.years.ago, 1.day.ago))

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









