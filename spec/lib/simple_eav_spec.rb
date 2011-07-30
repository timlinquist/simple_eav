require 'spec_helper'

describe SimpleEav do
  describe "Configuring a model" do
    it "with the column to serialize" do
      Person.simple_eav_column.should eql(:simple_attributes)
    end

    it "serializes the configured column" do
      p= Person.create({:simple_attributes => {:name=>'John'}})
      p.simple_attributes[:name].should eql('John')
    end
  end

  describe "Expected ActiveRecord behavior" do
    it "handles an empty string of attributes" do
      person = Person.create(:simple_attributes=>'')
      person.should_not be_new_record
    end
    describe "given a hash of undefined attributes" do
      it "creates a person with a name" do
        person = Person.create(:name=>'Joseph')
        person.name.should eql 'Joseph'
      end
      it "saves the person's name" do
        person = Person.new(:name=>'Jeremiah')
        person.save!
        person.reload
        person.name.should eql 'Jeremiah'
      end
      it "updates the person's name" do
        person = Person.create(:name=>'Joseph')
        person.update_attributes(:name=>'Joe')
        person.name.should eql 'Joe'
      end
      it "initializes the person with a name" do
        person = Person.new(:name=>'John')
        person.name.should eql 'John'
      end
    end
    describe "given a hash of defined attributes" do
      it "updates the person's age" do
        person = Person.create(:age=>98)
        person.update_attributes(:age=>99)
        person.save!
        person.reload
        person.age.to_i.should eql 99
      end
      it "does not set the age in the simple eav attributes" do
        person = Person.create(:age=>97, :new_age=>98)
        person.simple_eav_attributes.should_not have_key :age
        person.simple_eav_attributes.should have_key :new_age
      end
    end
    it "sets all of the attributes" do
      person = Person.create!({
        :age=>99,
        :simple_attributes=>{
          :name=>'John'
        }
      })
      person.age.should eql(99)
      person.name.should eql('John')
    end
    it "serializes and deserializes the simple_eav attributes" do
      person = Person.new({:simple_attributes=>{
        :name=>'John'
      }})
      person.save!
      person.reload
      person.name.should eql('John')
    end
  end
  
  describe "#method_missing" do
    it "does not reference the eav_column directly (causes stack overflow error)" do
      person = Person.new
      lambda{ person.name = 'John' }.should_not raise_error(SystemStackError)
    end
  end

  describe "A missing attribute" do
    before( :each ) do
      @person = Person.new
    end
    describe "when reading" do
      it "raises a NoMethodError" do
        lambda{ @person.unknown_eav }.should raise_error(NoMethodError)
      end
    end
    describe "when writing" do
      it "always defines the attribute without an error" do
        lambda{ @person.unknown_eav = 'Simple' }.should_not raise_error
      end
    end
  end
  
  describe "Adding an attribute with existing attributes" do
    before(:each) do
      @person = Person.create! :name=>'Jim'
    end
    
    it "updates the attributes without removing the old" do
      @person.update_attributes :cell_number => 911
      @person.name.should eql('Jim')
      @person.cell_number.should eql(911)
    end
  end

  describe "A custom attribute" do
    describe "John is a Person" do
      before( :each ) do
        @person = Person.new
      end
      it "who knows his name" do
        @person.name = 'John'
        @person.name.should eql('John')
      end

      it "who can change his name" do
        @person.name = 'John'
        @person.name = 'Joe'
        @person.name.should eql('Joe')
      end

      it "who responds to his name" do
        @person.name = 'John'
        @person.respond_to?(:name).should be_true
      end

      it "who doesn't respond to someone else's name" do
        @person.respond_to?(:someone_elses_name).should be_false
      end
    end
  end
end
