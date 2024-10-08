# 依存関係を逆転させる
# 注意：下記のコードではどちらに依存をさせても問題ないが、自身より変更されないものに依存するようにする
class Gear
  attr_reader :chainring, :cog

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire, :gear

  def initialize(rim, tire, chainring, cog)
    @rim = rim
    @tire = tire
    @gear = Gear.new(chainring,cog)
  end

  def diameter
    rim + (tire * 2)
  end

  # Gearとgear_inchesに依存している
  def gear_inches
    gear.gear_inches(diameter)
  end

end

puts Wheel.new(52, 11, 26, 1.5).gear_inches
