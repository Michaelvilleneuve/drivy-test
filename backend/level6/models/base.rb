class Base
  @@list = []
  
  def initialize(object)
    @@list << self
  end

  def self.delete_all
    @@list = []
  end

  protected

  def self.all(element)
    @@list.select { |object| object.is_a?(element) }
  end

  def destroy
    @@list.delete_at(@@list.index(self))
  end

end