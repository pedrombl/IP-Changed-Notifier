class IOStub < IO
  def initialize
    
  end
  def each
    yield '127.0.0.1'
  end
  
end