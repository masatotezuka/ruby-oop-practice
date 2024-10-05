require "forwardable"
require "ostruct"
# 自転車のパーツをコンポジションで表現する
class Bicycle
    attr_reader :size, :parts

    def initialize(args={})
        @size = args[:size]
        @parts = args[:parts]
    end
    
    def spares
        parts.spares
    end
end

# Bicycleのパーツを表現する
class Parts
    extend Forwardable
    def_delegators :@parts, :size, :each

    include Enumerable

    def initialize(parts)
        @parts = parts
    end

    def spares
        select { |part| part.needs_spare }
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


class Part 
    attr_reader :name, :description, :needs_spare

    def initialize(args)
        @name = args[:name]
        @description = args[:description]
        @needs_spare = args.fetch(:needs_spare, true)
    end
end


module PartsFactory
    def self.build(config,
                    parts_class = Parts,
                    part_class = Part)
    parts_class.new(
        config.map { |part_config|
            create_part(part_config)})
    end

    def self.create_part(part_config)
        # OpenStructは要素を動的に追加・削除できる手軽な構造体を提供するクラス
        # Partクラスからの依存がなくなり、コードの柔軟性が向上する
        OpenStruct.new(
            name: part_config[0],
            description: part_config[1],
            needs_spare: part_config.fetch(2, true)
        )
        # #<OpenStruct name="chain", description="10-speed", needs_spare=true>
    end
end

road_config = [['chain', '10-speed'],
                ['tire_size', '23'],
                ['tape_color', 'red']]

mountain_config =
 [['chain', '10-speed'],
  ['tire_size', '2.1'],
  ['front_shock', 'Manitou', false],
  ['rear_shock', 'Fox']]

road_parts = PartsFactory.build(road_config)
# => #<Parts:0x007f8f4b0b5a60 @parts=[#<Part:0x007f8f4b0b5a88 @name="chain", @description="10-speed", @needs_spare=true>, #<Part:0x007f8f4b0b5a60 @name="tire_size", @description="23", @needs_spare=true>, #<Part:0x007f8f4b0b5a60 @name="tape_color", @description="red", @needs_spare=true>]>
mountain_parts = PartsFactory.build(mountain_config)
puts road_parts


mountain_bike = Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(mountain_config)
)
