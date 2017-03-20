require_relative '../../DocumentUtils/basic_tokenizer'

class TermFrequency

  def initialize(tokenizer)
    @tokenizer = tokenizer
  end

  #Calculates the raw term frequency given the contents of the document.
  def calculate(text)
    return rawFrequency(text)
  end

  def info
    return "Raw term frequency (number of times a token appears in a given string - document)"
  end

  protected
  def rawFrequency(contents)
    _tokens = @tokenizer.tokenize(contents)
    _tf = Hash.new

    _tokens.each {
        |_token|
      if (!_tf.has_key?(_token))
        _tf[_token] = 1
      else
        _tf[_token] = _tf[_token] + 1
      end
    }
    return _tf
  end
end


