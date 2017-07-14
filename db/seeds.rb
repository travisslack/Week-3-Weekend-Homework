require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

require( 'pry-byebug' )

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new ({ 'name' => 'Dave', 'funds' => 50.00})
customer2 = Customer.new ({ 'name' => 'Geoff', 'funds' => 40.00})
customer3 = Customer.new ({ 'name' => 'Henry', 'funds' => 45.00})

customer1.save()
customer2.save()
customer3.save()

film1 = Film.new ({ 'title' => 'Trainspotting', 'price' => 6.00})
film2 = Film.new ({ 'title' => 'Jobs', 'price' => 8.00})
film3 = Film.new ({ 'title' => 'Tranformers', 'price' => 7.00})

film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new ({'film_id' => film1.id, 'customer_id' => customer1.id})
ticket2 = Ticket.new ({'film_id' => film2.id, 'customer_id' => customer1.id})
ticket3 = Ticket.new ({'film_id' => film3.id, 'customer_id' => customer1.id})
ticket1.save()
ticket2.save()
ticket3.save()


customer1.name = "Travis"
customer1.update
p customer1

film3.title = "Spiderman"
film3.update
p film3

















binding.pry
nil