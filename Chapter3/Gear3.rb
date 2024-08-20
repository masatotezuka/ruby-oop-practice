# インスタンス変数の作成を分離する
class Gear
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(chainring, cog,rim, tire)
        @chainring = chainring
        @cog = cog
        @rim = rim
        @tire = tire
    end

    # 
    def gear_inches
        ratio *  wheel.diameter
    end

    def ratio
        chainring / cog.to_f
    end
    
    # gear_inchesメソッドを呼び出すときに、Wheelのインスタンスを作成する
    def wheel
        @wheel ||= Wheel.new(rim, tire)
    end
end
# GearとWheelとの依存関係について
    # GearがWheelへ依存していることをあえて公然した書き方にしている
    # gear_inchesメソッドの依存数は1つになり、変更箇所が少なくなる

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