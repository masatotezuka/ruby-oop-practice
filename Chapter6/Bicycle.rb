# 継承ができていないコード
class Bicycle 
    attr_reader :style, :size, :tape_color, :front_shock, :rear_shock
    def initialize(args)
        @style = args[:style]
        @size = args[:size]
        @tape_color = args[:tape_color]
        @front_shock = args[:front_shock]
        @rear_shock = args[:rear_shock]
    end

    def spares 
        # ロードバイクとそれ以外で分岐していて、Bicycleの中で相違点がある
        # このクラスは、相違点もあるが関連している型を内包している
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

puts mountain_bike.spares


# 抽象クラスはサブクラス間で共有される振る舞いの共通の角の場所を提供する
# サブクラスはそれぞれに特化した振る舞いを用意する