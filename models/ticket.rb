require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id, :quantity

  def initialize(options)
    @id = options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (film_id, customer_id)
    VALUES
    (#{@film_id}, #{@customer_id})
    RETURNING id"
    ticket = SqlRunner.run(sql).first
    @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets
    SET (film_id, customer_id) = 
    (#{@film_id}, #{@customer_id})
    WHERE
    id = #{@id}"
    return SqlRunner.run(sql)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@user_id}"
    user = SqlRunner.run(sql).first
    return Customer.new(user)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = #{@user_id}"
    user = SqlRunner.run(sql).first
    return Film.new(user)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    return self.map_items(sql)
  end

  def self.delete_all() 
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end



end