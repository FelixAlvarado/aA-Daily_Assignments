 require_relative 'board.rb'
 require_relative 'game.rb'

class Card
attr_reader :face_value
attr_accessor :position, :exposed

def initialize(face_value)
 @face_value = face_value
 @exposed = false
end

def exposed?
  @exposed
end

def hide
  @exposed = false
end

def reveal
  @exposed = true
end

def to_s
end

def ==(other_card)
end

end
