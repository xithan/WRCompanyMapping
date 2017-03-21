require './company_mapper'
require_relative 'DocumentUtils/company_corpus'
require_relative 'tfidf/tfidf'


companiesCorpus = CompanyCorpus.new "data/list_of_wr_companies.csv"

new_company = TextDocument.new
new_company.contents = "BRF"

mapper = CompanyMapper.new(companiesCorpus)

#similarity threshold is set 0.5
puts mapper.map(new_company, 0.5)