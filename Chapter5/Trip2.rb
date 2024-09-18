# ダックタイピングを利用する
# ダックタイピング:オブジェクトの 型(クラス)を明示的に宣言せずに 、オブジェクトの振る舞い(メソッド)やプロパティを利用することで、そのオブジェクトの型(クラス)を推測する手法

class Trip
    attr_reader :bicycles, :customers, :vehicle
    
    # 抽象的なオブジェクトであるpreparersからメッセージを送ることで、Tripは具象クラスとの結びつきを減らす
    def prepare(preparers)
        preparers.each { |preparer|
        preparer.prepare_trip(self)
        }
    end
end
    
class Mechanic
    
    # Mechanicはprepare_tripメソッドを持つpreparerオブジェクトを知っている
    def prepare_trip(trip)
        trip.bicycles.each { |bicycle| prepare_bicycle(bicycle) }
    end
    
    def prepare_bicycle(bicycle)
        #...
    end
end
    
class TripCoordinator
    def prepare_trip(trip)
        buy_food(trip.customers)
    end
    
    def buy_food(customers)
        #...
    end
end
    
class Driver
    def prepare_trip(trip)
        gas_up(trip.vehicle)
        fill_water_tank(trip.vehicle)
    end
    
    def gas_up(vehicle)
        #...
    end
    
    def fill_water_tank(vehicle)
        #...
    end
end