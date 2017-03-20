require_relative './term_frequency'

# NormalizedTermFrequency inherits from TermFrequency class. It calculates Term Frequency as
# logarithmically scaled frequency: tf(t,d) = 1 + log(f(t,d)), or zero if
# f(t,d) is zero.

class NormalizedTermFrequency < TermFrequency

  def calculate(text)
    _rawTF = rawFrequency(text)
    _logTF = Hash.new

    _rawTF.each do |key, value|
      _logTF[key] = 1.0 + Math.log(value)
    end

    return _logTF
  end

  def info
    return "Logarithmically scaled term frequency: tf(t,d) = 1 + log(f(t,d)), or zero if ft,d is zero";
  end
end