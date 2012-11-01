require 'spec_helper'

describe Twix do
  describe "initialization" do
    it "pulls data from ~/.twixrc" do
      file = {'twitter' => {'consumer_key' => "CONSUMER_KEY",
              'consumer_secret' => "CONSUMER_SECRET",
              'oauth_token' => "OAUTH_TOKEN",
              'oauth_token_secret' => "OAUTH_TOKEN_SECRET"}}
      File.should_receive(:expand).with("~").and_return("/Users/chuck")
      YAML.should_receive(:load_file).with("/Users/chuck/.twixrc").and_return(file)
      Twitter.should_receive(:consumer_key=).with("CONSUMER_KEY")
      Twitter.should_receive(:consumer_secret=).with("CONSUMER_SECRET")
      Twitter.should_receive(:oauth_token=).with("OAUTH_TOKEN")
      Twitter.should_receive(:oauth_token_secret=).with("OAUTH_TOKEN_SECRET")
      Twix.init
    end
  end

  describe "execution" do
    it "executes on a username starting with '@' by listing the user's last 20 tweets" do
      tweets = [mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "\"Hello World\""),
                mock(:id => 1234567890, :text => "1+1"),
                mock(:id => 1234567890, :text => "require 'json'; JSON.parse({a: 1, b: 2})"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG"),
                mock(:id => 1234567890, :text => "ABCDEFG")]
      Twitter.should_receive(:user).with("@cmaxw).and_return(user)
      Twix.execute("@cmaxw")

    end
  end
end
