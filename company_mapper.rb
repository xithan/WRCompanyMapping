require_relative 'tfidf/tfidf'

#CompanyMapper given a corpus of documents (that contains company names) can map a new document with an existing one
#if one exists
class CompanyMapper

  def initialize(corpus)
    @corpus = corpus
    @tfidf = TFIDF.new(@corpus)
    @tfidf.calculate
  end

  #maps a given company to a company exists to the given corpus. If the maximum name similarity found exceeds the given
  # threshold then the company's id is returned as a match
  def map(company, threshold)
    @tfidf.calculate_tfidf_weights_of_new_document(company)

    _maxSim = 0.0
    _mapped_company = ""
    @corpus.each do |d|
      _similarity = @tfidf.similarity(d.id, company.id)

      if (_maxSim < _similarity)
        _maxSim = _similarity
        _mapped_company = d.id
        if (_maxSim == 1)
          break
        end
      end
    end

    if (_maxSim>threshold)
      return _mapped_company.to_s.sub(/\_.*/, "")
    else
      return nil
    end
  end
end