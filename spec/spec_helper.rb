require 'rspec'

require_relative '../DocumentUtils/company_corpus'
require_relative '../company_mapper'

shared_context "mapper" do
  before(:context) do
    corpus = CompanyCorpus.new("data/list_of_wr_companies.csv")
    @mapper = CompanyMapper.new(corpus)
  end
end
