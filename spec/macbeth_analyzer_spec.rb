require "spec_helper"

describe MacbethAnalyzer do

  before do
    xml_file = File.expand_path("../../spec/support/macbeth.xml", __FILE__)

    stub_request(:get, MacbethAnalyzer::URL).to_return(body: File.new(xml_file))
  end

  let!(:results) { MacbethAnalyzer.new.run }

  describe "Run Macbeth Analyzer" do

    it "ignores speaker 'ALL'" do
      expect(results.has_key?("ALL")).to eq(false)
    end

    it "returns correct results" do
      expect(results["MACBETH"]).to eq(718)
      expect(results["Soldiers"]).to eq(1)
      expect(results["ANGUS"]).to eq(21)
    end

    it "returns results sorted" do
      expect(results.values[0]).to be > results.values[1]
      expect(results.values[1]).to be > results.values[2]
      expect(results.values[2]).to be > results.values[3]
    end
  end
end
