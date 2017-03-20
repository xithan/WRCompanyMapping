require 'set'

#Implements Cosine Similarity between two non zero vectors and it measures the cosine of the angle between them.
class CosineSimilarity

  #Calculates cosine similarity between two documents. The documents are expressed as vectors of tokens (bag of words model).
  def calculate(doc1, doc2)
    return (dotProduct(doc1, doc2) / (Math.sqrt(d(doc1)) * Math.sqrt(d(doc2)))).round(4)
  end

  def info
    "Implements Cosine Similarity between two non zero vectors and it measures the cosine of the angle between them.\n"
    +"More info about Cosine Similarity can be found: https://en.wikipedia.org/wiki/Cosine_similarity";
  end

  protected
  #Calculated the dot product between the two document vectors. The dot product is an algebraic operation
  # that takes two equal-length sequences of numbers (usually coordinate vectors) and returns a single number.
  def dotProduct(doc1, doc2)
    _common_tokens = findCommonTokens(doc1.keys, doc2.keys)
    _dot_product = 0.0

    _common_tokens.each do |token|
      _dot_product += doc2[token] * doc1[token]
    end
    return _dot_product
  end

  #Calculates the magnitude of a vector document
  def d(doc)
    _d = 0.0
    doc.keys.each do |term|
      _d += doc[term]**2.0
    end
    return _d
  end

  #returns the set of common tokens between two document vectors
  def findCommonTokens(doc1_tokens, doc2_tokens)
    common_tokens = Set.new doc1_tokens
    return common_tokens.intersection(Set.new doc2_tokens)
  end
end
