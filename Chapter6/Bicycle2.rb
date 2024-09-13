# 抽象的なクラスを作成して、サブクラスでそれぞれの振る舞いを定義する
# 一旦すべて降格して、Bicycleクラスを作成する
# 抽象クラスはサブクラス間で共有される振る舞いの共通の角の場所を提供する
# サブクラスはそれぞれに特化した振る舞いを用意する
class Bicycle
    attr_reader :size, :chain, :tire_size

    def initialize(args={})
        @size = args[:size]
        @chain = args[:chain] || default_chain
        @tire_size = args[:tire_size] || default_tire_size
    end

    # サブクラスも共通なので、ここで初期値を定義する
    # テンプレートメソッドパターン：スーパークラス内で基本の構造を定義し、サブクラス固有の貢献を得るためにメッセージを送る
    def default_chain
        '10-speed'
    end

    # テンプレートメソッドパターンを使うどのクラスにも必ず実装するようにメッセージを送る
    def default_tire_size
        raise NotImplementedError, "This #{self.class} cannot respond to:"
    end

    def spares
        {tire_size: tire_size,chain: chain}
    end
end

class RoadBike < Bicycle 
    attr_reader :tape_color

    def initialize(args)
        @tape_color = args[:tape_color]
        super(args)
    end
    

    # サブクラスの初期値
    def default_tire_size
        '23'
    end
    
    def spares
        super.merge(tape_color: tape_color)
    end
end


class MountainBike < Bicycle
    attr_reader :front_shock, :rear_shock

    def initialize(args)
        @front_shock = args[:front_shock]
        @rear_shock = args[:rear_shock]
        super(args)
    end

    # サブクラスの初期値    
    def default_tire_size
        '2.1'
    end

    def spares
        super.merge(rear_shock: rear_shock)
    end
end

mountain_bike = MountainBike.new(
    size: 'S',
    front_shock: 'Manitou',
    rear_shock: 'Fox')

puts mountain_bike.size


puts mountain_bike.spares