# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts "starting.............................."

Review.destroy_all
Transaction.destroy_all
Car.destroy_all
User.destroy_all

puts "destroyed.............................."

# Seed users
10.times do
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    name: Faker::Name.name,
    description: Faker::Lorem.sentence
  )
end

puts "users done!"

Car.create(model: 'Ferrari Roma 2023', rating: 9.5, price: 400, location: 'Los Angeles', owner: User.all.sample, image_url: 'https://www.motortrend.com/uploads/2023/04/2023-Ferrari-Roma-exterior-8.jpg?fit=around%7C875:492.1875')
Car.create(model: 'Ferrari 458 Italia 2019', rating: 9.2, price: 370, location: 'Miami', owner: User.all.sample, image_url: 'https://i.ytimg.com/vi/YlRlOn5SUgQ/maxresdefault.jpg')
Car.create(model: 'BMW 3 series 2019', rating: 8.4, price: 120, location: 'Honolulu', owner: User.all.sample, image_url: 'https://cdn.motor1.com/images/mgl/174Wp/s1/2019-bmw-3-series.jpg')
Car.create(model: 'BMW 5 series 2020', rating: 8.6, price: 150, location: 'Sydney', owner: User.all.sample, image_url: 'https://www.carscoops.com/wp-content/uploads/2019/07/c7d5684d-bmw-5-series-facelift-rendering-2.jpg')
Car.create(model: 'Mercedes-Benz G-Class 2019', rating: 8.8, price: 250, location: 'Shanghai', owner: User.all.sample, image_url: 'https://di-uploads-pod3.dealerinspire.com/fletcherjonesmbnewport/uploads/2018/04/2019-G-G63-AMG-SUV-FUTURE-GALLERY-010-WR-D-1024x640.jpg')
Car.create(model: 'Mercedes-Benz C-Class 2017', rating: 8.5, price: 200, location: 'London', owner: User.all.sample, image_url: 'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/mercedes-benz-c-class-2017-silver-2.jpg')
Car.create(model: 'Lamborghini Aventador 2019', rating: 9.4, price: 380, location: 'Los Angeles', owner: User.all.sample, image_url: 'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/aventador-svj-price-1001x565-%281%29.jpg')
Car.create(model: 'Lamborghini Huracán 2020', rating: 9.5, price: 400, location: 'Miami', owner: User.all.sample, image_url: 'https://hips.hearstapps.com/hmg-prod/images/2020-lamborghini-huracan-evo-104-1576597210.jpg?crop=0.979xw:0.738xh;0.0208xw,0.216xh&resize=1200:*')
Car.create(model: 'Tesla Model Y 2019', rating: 8.8, price: 230, location: 'Honolulu', owner: User.all.sample, image_url: 'https://m.atcdn.co.uk/a/media/%7Bresize%7D/193c01b433a14e58b5b3c135741390e0.jpg')
Car.create(model: 'Tesla Model 3 2020', rating: 8.9, price: 180, location: 'Shanghai', owner: User.all.sample, image_url: 'https://carsguide-res.cloudinary.com/image/upload/f_auto%2Cfl_lossy%2Cq_auto%2Ct_default/v1/editorial/2019-Tesla-Model-3-Sedan-White-by-Matt-Campbell-1001x565_1_0.jpg')
Car.create(model: 'Porsche Panamera 2019', rating: 9.0, price: 300, location: 'London', owner: User.all.sample, image_url: 'https://www.bentleywashingtondc.com/imagetag/2294/main/l/Used-2019-Porsche-Panamera-Turbo-1605661743.jpg')
Car.create(model: 'Range Rover Evoque 2017', rating: 8.7, price: 200, location: 'Shanghai', owner: User.all.sample, image_url: 'https://f7432d8eadcf865aa9d9-9c672a3a4ecaaacdf2fee3b3e6fd2716.ssl.cf3.rackcdn.com/C984/U4423/IMG_11779-medium.jpg')
Car.create(model: 'Range Rover Sport 2019', rating: 8.8, price: 250, location: 'Shanghai', owner: User.all.sample, image_url: 'https://www.vogue4x4.com/assets/509366/large/2a0f68c897be2ece4b881c004199f338_509366.jpg')

puts "cody done!"

# Seed cars
10.times do
  puts "Creating cars"
  Car.create(
    model: Faker::Vehicle.model,
    rating: Faker::Number.between(from: 1, to: 5),
    price: Faker::Number.between(from: 10000, to: 50000),
    location: Faker::Address.city,
    owner: User.all.sample
  )
end

puts "cars done"

# Seed transactions
10.times do
  user = User.all.sample
  car = Car.where.not(user_id: user.id).sample
  puts Car.where.not(user_id: user.id)

  Transaction.create(
    start_date: Faker::Date.between(from: 1.month.ago, to: Date.today),
    end_date: Faker::Date.forward(days: 30),
    status: ["scheduled", "in progress", "completed"].sample,
    user_id: user.id,
    car_id: car.id
  )
end

puts "transactions done"

# Seed reviews
10.times do
  Review.create(
    rating: Faker::Number.between(from: 1, to: 5),
    cleanliness_rating: Faker::Number.between(from: 1, to: 5),
    maintenence_rating: Faker::Number.between(from: 1, to: 5),
    accuracy_rating: Faker::Number.between(from: 1, to: 5),
    content: Faker::Lorem.paragraph,
    user_id: User.pluck(:id).sample,
    transaction_id: Transaction.pluck(:id).sample
  )
end

puts "reviews done"
