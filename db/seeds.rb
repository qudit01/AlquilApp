# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

roles = [0, 1, 2]
9.times do |index|
  puts 'Generando usuario...'
  User.create(first_name: 'Lionel',
              last_name: 'Messo',
              role: roles[index % 3],
              email: "messi_#{index}@gmail.com",
              password: 1234,
              password_confirmation: 1234,
              dni: 1_234_123 + index,
              birthday: Time.zone.now - 18.years,
              latitude: -34,
              longitude: -57,
              state: 0)
end

9.times do |index|
  puts 'Generando billetera...'
  Wallet.create(money: 100_000,
                user: User.find(index + 1))
end

9.times do |index|
  puts 'Generando tarjetas...'
  Card.create(number: 1_234_432_112_341_230 + index,
              pin: 120 + index,
              expiration: Time.zone.now + 100.days + index.days,
              owner: User.find(index + 1).name,
              bank: 'Santander',
              kind: rand(0..2),
              user: User.find(index + 1),
              wallet: User.find(index + 1).wallet)
end

9.times do |index|
  puts 'Generando vehículo...'
  @car = Car.create(
    plate: "AAA#{index}",
    insurance: 'Sancor seguros',
    brand: 'Ford',
    model: 'Sport',
    kilometers: index * (index + 1),
    car_number: index,
    color: "Azul ópalo",
    latitude: -34,
    longitude: -57,
    fuel: 0
  )
  puts @car.errors[:car_number]
end
