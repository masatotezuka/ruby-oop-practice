# 抽象的なクラスを作成する
# 一旦すべて降格して、Bicycleクラスを作成する
class Bicycle

end

class RoadBike < Bicycle 
    # かつてのBicycleクラスのコードをすべてここに含む
    attr_reader :style, :size, :tape_color, :front_shock, :rear_shock

    def initialize(args)
        @style = args[:style]
        @size = args[:size]
        @tape_color = args[:tape_color]
        @front_shock = args[:front_shock]
        @rear_shock = args[:rear_shock]
    end

    def spares 
        if style == :road
            { chain: '10-speed',
              tire_size: '23',
              tape_color: tape_color }
        else
            { chain: '10-speed',
              tire_size: '2.1',
              rear_shock: rear_shock }
        end
    end
end


class MountainBike < Bicycle
    attr_reader :front_shock, :rear_shock

    def initialize(args)
        @front_shock = args[:front_shock]
        @rear_shock = args[:rear_shock]
        super(args)
    end

    def spares
        super.merge(rear_shock: rear_shock)
    end
end

mountain_bike = MountainBike.new(
    size: 'S',
    front_shock: 'Manitou',
    rear_shock: 'Fox')

# 現時点では、スーパークラスにsizeが存在しないので。エラーが出る
puts mountain_bike.size
