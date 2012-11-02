require 'spec_helper'

describe Twix do
  describe "initialization" do
    it "pulls data from ~/.twixrc" do
      file = {'twitter' => {'consumer_key' => "CONSUMER_KEY",
              'consumer_secret' => "CONSUMER_SECRET",
              'oauth_token' => "OAUTH_TOKEN",
              'oauth_token_secret' => "OAUTH_TOKEN_SECRET"}}
      File.should_receive(:expand_path).with("~").and_return("/Users/chuck")
      YAML.should_receive(:load_file).with("/Users/chuck/.twixrc").and_return(file)
      Twitter.should_receive(:consumer_key=).with("CONSUMER_KEY")
      Twitter.should_receive(:consumer_secret=).with("CONSUMER_SECRET")
      Twitter.should_receive(:oauth_token=).with("OAUTH_TOKEN")
      Twitter.should_receive(:oauth_token_secret=).with("OAUTH_TOKEN_SECRET")
      Twix.init
    end
  end

  describe "execution" do
    before :each do
      @tweets = [mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "puts \"Hello World\""),
                mock(:id => 1234567890, :text => "1+1"),
                mock(:id => 1234567890, :text => "require 'json'; JSON.parse(\"{a: 1, b: 2}\")"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG")]
    end

    it "executes on a username starting with '@' by listing the user's last 20 tweets" do
      Twitter.should_receive(:user_timeline).with("cmaxw").and_return(@tweets)
      $stdin.should_receive(:gets).and_return("0\n")
      $stdout.should_receive(:puts).exactly(@tweets.count + 1).times.and_return(true)
      Twix.should_receive(:execute_tweet).with("ABCDEFG").and_return("Hello World")
      Twix.run(["@cmaxw"])
    end

    it "executes a tweet when its id is provided" do
      Twitter.should_receive(:status).with("12345").and_return(@tweets[1])
      Twix.should_receive(:execute_tweet).with("puts \"Hello World\"").and_return("Hello World")
      Twix.run(["12345"])
    end
  end

  describe "safety" do
    it "sets safe level to 4 and rubycop on." do
      Twitter.should_receive(:status).with("12345").and_return(mock(:text => "puts `ls -al`"))
      RubyCop::NodeBuilder.should_receive(:build).with("puts `ls -al`").and_return(mock(:accept => true))
      Twix.run(["12345"])
      Twix.safe_level.should == 4
    end

    it "user can adjust safe level" do
      Twitter.should_receive(:status).with("12345").and_return(mock(:text => "puts \"Hello World\""))
      Twix.should_receive(:execute_tweet).with("puts \"Hello World\"").and_return("Hello World")
      Twix.run(["-s2", "12345"])
      Twix.safe_level.should == 2
    end

    it "--naked sets safe level to 0" do
      Twitter.should_receive(:status).with("12345").and_return(mock(:text => "puts \"Hello World\""))
      RubyCop::NodeBuilder.should_not_receive(:build)
      Twix.run(["--naked", "12345"])
      Twix.safe_level.should == 0
      Twix.ruby_cop?.should == false
    end

    it "--no-cop turns off RubyCop" do
      Twitter.should_receive(:status).with("12345").and_return(mock(:text => "puts \"Hello World\""))
      Twix.should_receive(:execute_tweet).with("puts \"Hello World\"").and_return("Hello World")
      Twix.run(["--no-cop", "12345"])
      Twix.ruby_cop?.should == false
    end
  end
end
