class Corpus

  def initialize
    @corpus = Set.new
  end

  def push(document)
    @corpus.add(document)
  end

  def size
    return @corpus.size
  end

  def each
    @corpus.each do |doc|
      yield(doc)
    end
  end
end