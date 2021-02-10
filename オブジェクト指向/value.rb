# 値をオブジェクトに切り出す設計のよさ 2020/2/10

# ゲームを作っていて、座標で位置を確認したい
class Player
  attr_accessor :name, :x, :y
  def initialize(name, x, y)
    self.name = name
    self.x = x
    self.y = y
  end
end

# 一応上記でもうまくいきそうだけど、敵を作ろうとかしてこうして
class Enemy
  attr_accessor :name, :x, :y
  def initialize(name, x, y)
    self.name = name
    self.x = x
    self.y = y
  end
end

player = Player.new("Player01", 5, 5)
enemy = Enemy.new("Ememy01", 2, 3)

# 位置が同じ判定をするときにこうするのはだるい
if player.x == enemy.x && player.y == enemy.y

end

class Position
  attr_accessor :x, :y
  def initialize(x, y)
    self.x = x
    self.y = y
  end
 
  # 同座標判定をここに作る
  def ==(position)
    x == position.x && y == position.y
  end
end

# 座標をつくって実験してみる

position_a = Position.new(1, 3)
position_b = Position.new(1, 3)
position_c = Position.new(2, 4)

puts position_a == position_b # true
puts position_a == position_c # false

# Player クラス　Enemy　クラスをリファクタリング

class Player
  attr_accessor :name, :position
  def initialize(name, position)
    self.name = name
    self.position = position
  end
end

class Enemy
  attr_accessor :name, :position
  def initialize(name, position)
    self.name = name
    self.position = position
  end
end

# Positionを渡して初期化できる
player = Player.new("Player01", position_a)
enemy = Enemy.new("Ememy", position_b)

# 同座標判定もだるくない
player.position == enemy.position

# 座標に対する定型の操作も Positionクラスの拡張で対応できる
class Position
  attr_accessor :x, :y
  def initialize(x, y)
    self.x = x
    self.y = y
  end
 
  # 同座標判定をここに作る
  def ==(position)
    x == position.x && y == position.y
  end

  # 指定した位置に飛ぶ
  def move_to(x, y)
    self.x = x
    self.y = y
  end
end

player.position.move_to(5,5)
p player.position # <Position:0x00000000064a91c8 @x=5, @y=5>
