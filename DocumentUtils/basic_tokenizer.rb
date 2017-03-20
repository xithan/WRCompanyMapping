#BasicTokenizer breaks given strings to a set of tokens. As tokens are regarded the words and the sequences of
# the numbers the string contains.
class BasicTokenizer

  def initialize(ignorePunctuation = true, ignoreCase = true)
    @doIgnorePunctuation, @doIgnoreCase = ignorePunctuation, ignoreCase
  end

  def to_s
    "{BasicTokenizer: (IgnoresPunctuation: #@doIgnorePunctuation, IgnoresCase: #@doIgnoreCase)}"
  end

  def tokenize(text)
    _text = tranform(text)
    _tokens = Array.new
    _index = 0;
    while (_index<_text.length)
      _char = String(_text[_index])
      if (_char.match(/\s/))
        _index = _index+1
      elsif (_char.match(/\w/))
        _buf = StringIO.new("")
        while ((_index < _text.length) && (_text[_index].match(/\w/)))
          _buf << _text[_index]
          _index += 1
        end
        _tokens.push(_buf.string)
      else
        if (!@doIgnorePunctuation)
          _buf = StringIO.new("")
          _buf << _char
          _tokens.push(_buf.string)
        end
        _index += 1
      end
    end
    return _tokens
  end

  private
  def tranform(text)
    if (@doIgnoreCase)
      return text.to_s.downcase
    end
    return text.to_s
  end
end
