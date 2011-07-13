require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "WhoopsLogger::MessageCreator" do
  describe "#initialize" do
    it "should raise an exception if strategy is nil" do
      lambda{WhoopsLogger::MessageCreator.new(nil, {})}.should raise_exception(ArgumentError)
    end
    
    it "should raise an exception if strategy argument does not respond to call" do
      lambda{WhoopsLogger::MessageCreator.new(true, {})}.should raise_exception(ArgumentError)
    end
    
    it "should not raise an exception if strategy argument responds to call" do
      lambda{WhoopsLogger::MessageCreator.new(Proc.new{}, {})}.should_not raise_exception
    end
  end
  
  describe "#create!" do
    it "should not send message if ignore_message? is true" do
      strategy = lambda{}
      message_creator = WhoopsLogger::MessageCreator.new(strategy, {})
      message_creator.stub(:ignore_message?).and_return(true)
      
      message_creator.should_not_receive(:send_message)
      
      message_creator.create!
    end
  end  
end