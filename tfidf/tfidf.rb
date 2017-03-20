require_relative '../DocumentUtils/basic_tokenizer'
require_relative 'idf/inverse_document_frequency'
require_relative 'tf/normalized_term_frequency'
require_relative '../StringSimilarities/cosine_similarity'

#TFIDF class implements Term Frequency Inverse Document Frequency statistic.
class TFIDF
  attr_accessor :tf, :idf

  def initialize(corpus)
    @corpus = corpus
  end

  #Calculates the tf-idf weights in the given corpus
  def calculate
    @tfidf = Hash.new

    if (@idf==nil)
      @idf = InverseDocumentFrequency.new(@corpus)
    end

    if (@tf==nil)
      _tokenizer = BasicTokenizer.new
      @tf = NormalizedTermFrequency.new(_tokenizer)
    end

    @idf_weights = @idf.calculate

    @corpus.each {
        |doc|

      _termfreq = @tf.calculate(doc.contents)

      _tfidf_weights = Hash.new

      _termfreq.each do |term, tf|
        _weight = tf * @idf_weights[term]
        _tfidf_weights[term] = _weight
      end

      @tfidf[doc.id] = _tfidf_weights
    }
    return @tfidf
  end

  #Calculates tfidf weights of new incoming document without importing the document in the corpus and re-calculating the tf-idf weights for the entire corpus
  def calculate_tfidf_weights_of_new_document(new_doc)
    _termfreq = @tf.calculate(new_doc.contents)

    _tfidf_weights = Hash.new

    _termfreq.each do |term, tf|
      if (@idf_weights.has_key? term)
        _weight = tf * @idf_weights[term]
      else
        _weight = tf * @idf.maxIDF
      end
      _tfidf_weights[term] = _weight
    end
    @tfidf[new_doc.id] = _tfidf_weights
    return @tfidf
  end

  #Calculates tf-idf similarity between two given documents. It is actually
  #the calculated Cosine Similarity by using tf*idf weights.
  def similarity(doc1_id, doc2_id)
    if (@tfidf==nil)
      calculate
    end

    _cosine_similarity = CosineSimilarity.new
    return _cosine_similarity.calculate(@tfidf[doc1_id], @tfidf[doc2_id])
  end

  def info
    " term frequency–inverse document frequency, is a numerical "
    +"statistic that is intended to reflect how important a word "
    +"is to a document in a collection or corpus"
  end
end