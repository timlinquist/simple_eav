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

  describe "A custom attribute" do
    describe "Person" do
      before( :each ) do
        @person = Person.new
      end
      it "John knows his name" do
        @person.name = 'John'
        @person.name.should eql('John')
      end

      it "John responds to his name" do
        pending
        @person.name = 'John'
        @person.respond_to?(:name).should be_true
      end

      it "John can change his name"
      it "John can become John Doe"
    end
  end
end
