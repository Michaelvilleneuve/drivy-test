class Base
  @@list = []
  
  def initialize(object)
    @@list << self
  end

  protected

  def self.all(element)
    @@list.select { |object| object.is_a?(element) }
  end
end