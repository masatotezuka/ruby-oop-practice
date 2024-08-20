# 引数の順番の順番の依存を取り除く


class Gear
    attr_reader :chainring, :cog, :rim, :tire
    # 引数をハッシュに変更することで、引数の順番の依存を取り除く
    def initialize(args)
        @chainring = args[:chainring]
        @cog = args[:cog]
        @rim = args[:rim]
        @tire = args[:tire]
    end

end


class Gear2
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(args)
        # mergeメソッドでデフォルト値のハッシュをマージする
        args = defaults.merge(args)
        @chainring = args[:chainring]
        @cog = args[:cog]
        @rim = args[:rim]
        @tire = args[:tire]
    end

    def defaults
        { chainring: 40, cog: 18 }
    end

    def ratio
        chainring / cog.to_f
    end
end

class Gear3
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(args)
        # fetchメソッドでデフォルト値を設定する
        @chainring = args.fetch(:chainring, 40)
        @cog = args.fetch(:cog, 18)
        @rim = args[:rim]
        @tire = args[:tire]
    end
end


puts Gear.new({chainring: 52, cog: 11, rim: 26, tire: 1.5}).chainring
puts Gear2.new({chainring: 52, rim: 26, tire: 1.5}).ratio
puts Gear3.new({rim: 26, tire: 1.5}).chainring