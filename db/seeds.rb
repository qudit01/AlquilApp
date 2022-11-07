# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |index|
  User.create(first_name: 'Emi',
              last_name: "Seedeado",
              role: 1,
              email: "emilio_#{index}@gmail.com",
              password: 1234,
              password_confirmation: 1234,
              dni: 1_234_123 + index)
end

10.times do |index|
  Wallet.create(money: 100_000,
                user: User.find(index + 1))
end

10.times do |index|
  Card.create(number: 1_234_432_112_341_230 + index,
              pin: 120 + index,
              expiration: Time.zone.now + 100.days + index.days,
              owner: "Un nombre sedeeado",
              bank: "Banco sedeeado",
              kind: rand(0..2),
              user: User.find(index + 1),
              wallet: User.find(index + 1).wallet)
end