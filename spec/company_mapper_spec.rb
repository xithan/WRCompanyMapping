require 'spec_helper'

RSpec.describe CompanyMapper do
  include_context "mapper"

  def company_doc name
    new_company = TextDocument.new
    new_company.contents = name
    new_company
  end

  def map company_name
    @mapper.map(company_doc(company_name), threshold)
  end

  let(:brf_id) { "57493" }

  context "threshold 0.5" do
    let(:threshold) { 0.5 }

    it "maps 'BRF'" do
      expect(map "brf").to eq brf_id
    end

    it "maps 'BRF.'" do
      expect(map "BRF.").to eq brf_id
    end

    it "maps 'brf Inc.'" do
      expect(map"brf Inc.").to eq brf_id
    end

    it "maps 'brf co'" do
      expect(map"brf co").to eq brf_id
    end

    it "does not map 'brff'" do
      expect(map"brff").to eq nil
    end
  end

  context "threshold 0.9" do
    let(:threshold) { 0.9 }

    it "maps 'BRF'" do
      expect(map "BRF").to eq brf_id
    end

    it "does not map brf co" do
      expect(map"brf co").to eq nil
    end
  end
end
