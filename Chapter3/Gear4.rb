# 脆い外部メッセージを隔離する
# 脆い外部メッセージとは、self以外に送られるメッセージ（=他のオブジェクトの内部構造に依存しているメッセージのこと）

class Gear
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(chainring, cog,rim, tire)
        @chainring = chainring
        @cog = cog
        @rim = rim
        @tire = tire
    end

    def gear_inches
        # ...複雑な処理がある
        ratio *  diameter
        # ...複雑な処理がある
    end

    def ratio
        chainring / cog.to_f
    end

    def wheel
        @wheel ||= Wheel.new(rim, tire)
    end
    # diameterメソッドを追加することで、Wheelがdiaeterの名前やシグネチャーを変更しても、Gearへの副作用はこのラッパーメソッド内に収められる
    def diameter
        wheel.diameter
    end
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


puts "Gear.new(52, 11, 26, 1.5).gear_inches"
puts Gear.new(52, 11, 26, 1.5).gear_inches