# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Car.create!(model: 'Ferrari Roma 2023', rating: 9.5, price: 400, location: 'Los Angeles', user: User.last)
Car.create(model: 'Ferrari 458 Italia 2019', rating: 9.2, price: 370, location: 'Miami', user: User.last)
Car.create(model: 'BMW 3 series 2019', rating: 8.4, price: 120, location: 'Honolulu', user: User.last)
Car.create(model: 'BMW 5 series 2020', rating: 8.6, price: 150, location: 'Sydney', user: User.last)
Car.create(model: 'Mercedes-Benz G-Class 2019', rating: 8.8, price: 250, location: 'Shanghai', user: User.last)
Car.create(model: 'Mercedes-Benz C-Class 2017', rating: 8.5, price: 200, location: 'London', user: User.last)
Car.create(model: 'Lamborghini Aventador 2019', rating: 9.4, price: 380, location: 'Los Angeles', user: User.last)
Car.create(model: 'Lamborghini Huracán 2020', rating: 9.5, price: 400, location: 'Miami', user: User.last)
Car.create(model: 'Tesla Model Y 2019', rating: 8.8, price: 230, location: 'Honolulu', user: User.last)
Car.create(model: 'Tesla Model 3 2020', rating: 8.9, price: 180, location: 'Shanghai', user: User.last)
Car.create(model: 'Porsche 911 2021', rating: 9.2, price: 250, location: 'Sydney', user: User.last)
Car.create(model: 'Porsche Panamera 2019', rating: 9.0, price: 300, location: 'London', user: User.last)
Car.create(model: 'Range Rover Evoque 2017', rating: 8.7, price: 200, location: 'Shanghai', user: User.last)
Car.create(model: 'Range Rover Sport 2019', rating: 8.8, price: 250, location: 'Shanghai', user: User.last)
