puts 'ユーザーを作成するseed実行中...'

10.times do |n|
  user = User.create!(name: Faker::Games::Pokemon.unique.name,
                email: Faker::Internet.unique.email,
              password: "password",
            password_confirmation: "password")
  puts "#{user.name}"
end
