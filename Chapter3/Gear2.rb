# 依存オブジェクトの注入（DI）
class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
        @chainring = chainring
        @cog = cog
        @wheel = wheel
    end

    def gear_inches
        ratio *  @wheel.diameter
    end

    def ratio
        chainring / cog.to_f
    end
end
# GearとWheelとの依存関係について
# Wheelのインスタンスの作成とGearクラスの外に移動したことで、2つのクラス間の結合が切り離された
# => 依存オブジェクトの注入（DI）を使って、GearがWheelに依存することを避けることができる

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


puts "Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches"
puts Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches