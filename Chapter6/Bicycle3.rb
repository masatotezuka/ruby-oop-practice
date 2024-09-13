# フックメッセージを使って、サブクラスを疎結合にする
class Bicycle
    attr_reader :size, :chain, :tire_size

    def initialize(args={})
        @size = args[:size]
        @chain = args[:chain] || default_chain
        @tire_size = args[:tire_size] || default_tire_size

        post_initialize(args)
    end

    def default_chain
        '10-speed'
    end

    def default_tire_size
        raise NotImplementedError, "This #{self.class} cannot respond to:"
    end

    def spares
        {tire_size: tire_size,chain: chain}.merge(local_spares)
    end

    # サブクラスでオーバーライドするためのフック
    def post_initialize(args)
        nil
    end

    # サブクラスでオーバーライドするためのフック
    def local_spares
        {}
    end
end

class RoadBike < Bicycle 
    attr_reader :tape_color


    # superでメッセージを送る必要はない
    # いつ初期化されるかの責任はスーパークラスにある
    def post_initialize(args)
        @tape_color = args[:tape_color]
    end
    

    def default_tire_size
        '23'
    end
    
    # local_sparesが何らかのオブジェクトによって、何らかの場合で呼び出されることを想定するだけ
    def local_spares
        {tape_color: tape_color}
    end
end


class MountainBike < Bicycle
    attr_reader :front_shock, :rear_shock

    def post_initialize(args)
        @front_shock = args[:front_shock]
        @rear_shock = args[:rear_shock]
    end

    # サブクラスの初期値    
    def default_tire_size
        '2.1'
    end

    def local_spares
        {rear_shock: rear_shock}
    end
end

mountain_bike = MountainBike.new(
    size: 'S',
    front_shock: 'Manitou',
    rear_shock: 'Fox')

puts mountain_bike.size


puts mountain_bike.spares