class Engine
  def start
    puts "Engine started"
  end
end

class Car
  attr_reader :engine

  def initialize
    @engine = Engine.new
  end

  # DriverがCarの内部構造を知らなくても、Carのインターフェースを通じてエンジンを起動できる
  def start_engine
    @engine.start
  end
end

class Driver
  def initialize(car)
    @car = car
  end

  def start_car
    @car.start_engine
  end
end

car = Car.new
driver = Driver.new(car)
driver.start_car

# デメテルの法則に違反してるケース
class Driver
  def initialize(car)
    @car = car
  end

  def start_car
    # DriverがCarの内部構造を知っている
    @car.engine.start  
  end
end
