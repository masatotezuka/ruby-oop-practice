# 自転車のパーツをコンポジションで表現する
class Bicycle
    attr_reader :size, :parts

    def initialize(args={})
        @size = args[:size]
        @parts = args[:parts]
    end
    
    def spare_parts
        parts.spares
    end
end


# Bicycleのパーツを表現する
class Parts
    attr_reader :chain, :tire_size

    def initialize(args={})
        @chain = args[:chain] || default_chain
        @tire_size = args[:tire_size] || default_tire_size
        post_initialize(args)
    end


    def spares
        {tire_size: tire_size,chain: chain}.merge(local_spares)
    end


    def default_chain
        '10-speed'
    end


    def default_tire_size
        raise NotImplementedError
    end
    

    def post_initialize(args)
        nil
    end


    def local_spares
        {}
    end
end


class RoadBikeParts < Parts
    attr_reader :tape_color

    def post_initialize(args)
        @tape_color = args[:tape_color]
    end

    def default_tire_size
        '23'
    end

    def local_spares
        {tape_color: tape_color}
    end
end

class MountainBikeParts < Parts
    attr_reader :front_shock, :rear_shock

    def post_initialize(args)
        @front_shock = args[:front_shock]
        @rear_shock = args[:rear_shock]
    end

    def default_tire_size
        '2.1'
    end

    def local_spares
        {rear_shock: rear_shock}
    end
end


road_bike = Bicycle.new(
    size: 'L',
    parts: RoadBikeParts.new(
        tape_color: 'red'
    )
)

puts road_bike.size
puts road_bike.spare_parts
# => L
# => {:chain=>"10-speed", :tire_size=>"23"}
