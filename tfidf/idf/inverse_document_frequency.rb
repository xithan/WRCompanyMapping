require_relative '../../DocumentUtils/corpus'
require_relative '../../DocumentUtils/text_document'


#InverseDocumentFrequency consists the basic implementation of inverse document frequency. It is the logarithmically
#scaled inverse fraction of the documents that contain the token, obtained by dividing the total number of documents by
#the number of documents containing the token, and then taking the logarithm of that quotient.

class InverseDocumentFrequency

  def initialize(corpus)
    @corpus = corpus
  end

  #Calculates the basic Inverse Document Frequency of each token contained in a corpus of documents.
  def calculate
    _df = document_frequency
    _idf = Hash.new


    _df.each do |word, freq|
      _idf[word] = Math.log(@corpus.size/freq)
    end
    return _idf
  end

  def info
    "The inverse document frequency is a measure of how much "
    +"information the word provides, that is, whether the term is "
    +"common or rare across all documents of a corpus. It is the logarithmically "
    +"scaled inverse fraction of the documents that contain the token,"
    +" obtained by dividing the total number of documents by the number "
    +"of documents containing the token, and then taking the logarithm "
    +"of that quotient."
  end

  def maxIDF
    return Math.log(@corpus.size * 1.0)
  end

  protected

  #calculates the number of document occurrences of unique tokens within a corpus
  def document_frequency
    _df = Hash.new

    @corpus.each do |doc|
      _words = doc.bag_of_words.keys

      _words.each do |word|
        if (_df.has_key?(word))
          _df[word] = _df[word]+1.0
        else
          _df[word] = 1.0
        end
      end
    end
    return _df
  end
end

