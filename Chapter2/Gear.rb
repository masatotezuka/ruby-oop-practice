class Gear
    # インスタンス変数をアクセサメソッドで包むことで、変更量を小さくできる
    attr_reader :chainring, :cog, :wheel
    # NOTE: attr_readerは、インスタンス変数の読み出し専用アクセサを定義できる
    # https://qiita.com/aberyotaro/items/626a88388d44802240a0
    # 以下のコードは、attr_readerを使わない場合のコード
    # def chainring
    #     @chainring
    # end
    def initialize(chainring, cog, wheel)
        @chainring = chainring
        @cog = cog
        @wheel = wheel
    end

    def ratio
        chainring / cog.to_f
    end

    # NOTE: 下記のようにStructでWheelを定義すると、GearクラスはWheelに依存する。インスタンスするときにWheelを渡す必要がある
    # また、現実世界ではWheelはGearだけに依存はしないはず
    # Wheel = Struct.new(:rim, :tire) do
    #     def diameter
    #         rim + (tire * 2)
    #     end
    # end
end


class Wheel
    attr_reader :rim, :tire

    def initialize(rim, tire)
        @rim = rim
        @tire = tire
    end

    def diameter
        rim + (tire * 2)
    end

    def circumference
        diameter * Math::PI
    end
end

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference

puts Gear.new(52, 11, @wheel).ratio
puts Gear.new(30, 27, @wheel).ratio