class Gear
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(chainring, cog,rim, tire)
        @chainring = chainring
        @cog = cog
        @rim = rim
        @tire = tire
    end

    def gear_inches
        ratio *  Wheel.new(rim, tire).diameter
    end

    def ratio
        chainring / cog.to_f
    end
end
# GearとWheelとの依存関係について
    # - GearはWheelという名前のクラスが存在することを知っている
    # - GearはWheelのインスタンスがdiaeteに応答することを知っている
    # - GearはWheel.newにrim, tireが必要であることを知っている
    # - GearはWheel.newの最初の引数がrimで、2番目がtireであることを知っている
# => 依存関係が多いと、変更が発生したときに変更箇所が多くなる（例：Wheelのinitializeメソッドの引数の順番を変えるとGearのnewメソッドの引数の順番も変える必要がある）

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