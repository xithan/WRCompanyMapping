require 'net/http'
require 'json'
require 'csv'
require './company_mapper'
require_relative 'DocumentUtils/corpus'
require_relative 'DocumentUtils/text_document'
require_relative 'tfidf/tfidf'

#building a corpus from the data/list_of_wr_companies.csv file
def buildCorpus
  _companies = Corpus.new

  CSV.foreach("data/list_of_wr_companies.csv") do |row|
    _array = row[0].split(";")

    _doc = TextDocument.new
    _doc.contents = _array[1].gsub(",", "").gsub(".", "")
    _doc.id = _array[0]

    _companies.push(_doc)
    for i in 2..(_array.size-1)
      _alias =

          _alias_doc = TextDocument.new
      _alias_doc.contents = _array[i].gsub(",", "").gsub(".", "")
      _alias_doc.id = _array[0] + "_" + i.to_s

      _companies.push(_alias_doc)

    end
  end

  return _companies
end

companiesCorpus = buildCorpus

new_company = TextDocument.new

new_company.contents = "BRF"

mapper = CompanyMapper.new(companiesCorpus)

#similarity threshold is set 0.5
puts mapper.map(new_company, 0.5)