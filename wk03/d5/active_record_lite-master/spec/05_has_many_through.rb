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
      self.table_name = humans
    end

    class House < SQLObject
      has_many :humans
      has_many_through :cats, :humans, :cats
    end
  end

  describe "::has_many_through" do
    let(:house1) = House.find(1)
    before(:each) { cats = house1.cats }

    it "returns an array" do
      expect(cats.is_a?(Array)).to be true
    end

    
  end
end