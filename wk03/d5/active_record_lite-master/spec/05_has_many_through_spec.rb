require 'active_record_lite/04_associatable2'

describe 'Associatable' do
  before(:each) { DBConnection.reset }
  after(:each) { DBConnection.reset }

  before(:all) do
    class Cat < SQLObject
      belongs_to :human, foreign_key: :owner_id
    end

    class Human < SQLObject
      belongs_to :house 
      has_many :cats, foreign_key: :owner_id
      self.table_name = 'humans'
    end

    class House < SQLObject
      has_many :humans
      has_many_through :cats, :humans, :cats
    end
  end

  describe "::has_many_through" do
    let(:house1) {House.find(1)}
    let(:cats) { house1.cats }

    it "returns an array" do
      expect(cats.is_a?(Array)).to be true
    end

    it "contains cats objects" do 
      expect(cats[0]).to be_a(Cat)
    end

    it "returns two results" do 
      expect(cats.length).to be 2
    end

    it "contains Breakfast and Earl" do 

      cat_names = cats.map { |cat| cat.name }

      expect(cat_names).to include("Breakfast")
      expect(cat_names).to include("Earl")
    end
  end
end