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
    it "set all of the attributes" do
      person = Person.create!({
        :age=>'John Johnson',
        :simple_attributes=>{
          :name=>'John'
        }
      })
      person.age.should eql('John Johnson')
      person.name.should eql('John')
    end
    it "serialize and deserialize the simple_eav attributes" do
      person = Person.new({:simple_attributes=>{
        :name=>'John'
      }})
      person.save!
      person.reload
      person.name.should eql('John')
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
