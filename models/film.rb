require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_f
  end

  def save()
    sql = "INSERT INTO films
    (title, price)
    VALUES
    ('#{@title}', #{@price})
    RETURNING id"
    film = SqlRunner.run(sql).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET (title, price) = 
    ('#{@title}', #{@price})
    WHERE
    id = #{@id}"
    return SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* from customers 
    INNER JOIN visits ON visits.customer_id = customer.id
    WHERE user_id = #{@id}"
    return Customer.map_items(sql)
  end

  def self.find(id_input)
    sql = "
    SELECT * FROM films WHERE id = #{id_input}"
    film = SqlRunner.run(sql)[0]
    result = Film.new(film) 
    return result
    end

  def self.all()
    sql = "SELECT * FROM films"
    return self.map_items(sql)
  end

  def self.delete_all() 
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new(film) }
    return result
  end

end