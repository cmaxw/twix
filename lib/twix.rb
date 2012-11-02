#encoding: UTF-8

require 'oauth'
require 'twitter'
require 'yaml'
require 'ruby_cop'
require 'pry'

class Twix
  def self.init
    config_file = File.expand_path("~") + "/.twixrc"
    twix_config = YAML.load_file(config_file)
    Twitter.configure do |config|
       config.consumer_key = twix_config['twitter']['consumer_key']
       config.consumer_secret = twix_config['twitter']['consumer_secret']
       config.oauth_token = twix_config['twitter']['oauth_token']
       config.oauth_token_secret = twix_config['twitter']['oauth_token_secret']
    end
  end

  def self.run(args)
    @args = args
    handle_switches
    if args.last.match(/\A@/)
      show_user_tweets(args.last)
    elsif args.last =~ /\A[0-9]+\Z/
      tweet = Twitter.status(args.last)
      execute_tweet(tweet)
    end
  end

  private

  def self.handle_switches
    set_use_ruby_cop(!has_switch?("naked"))
  end

  def self.set_use_ruby_cop(on = true)
    @ruby_cop = on
  end

  def self.ruby_cop?
    @ruby_cop
  end

  def self.has_switch?(switch)
    !!get_switch(switch)
  end

  def self.get_switch(switch)
    dashes = switch.length == 1 ? "-" : "--"
    @args.detect{|a| a.match(/\A#{dashes}#{switch}/) }
  end

  def self.show_user_tweets(user)
    timeline = Twitter.user_timeline(user.gsub(/\A@/, ''))
    puts "Tweets for #{user}:"
    timeline.each_with_index do |tweet, index|
      display_tweet(tweet, index)
    end
    print "\nWhich Tweet do you want to execute? "
    tweet_index = $stdin.gets.chomp
    if tweet_index.match(/\A(1|)[0-9]\Z/).nil?
      puts "\n\nYour input must be between 0 and 19"
      show_user_tweets(user)
    else
      execute_tweet timeline[tweet_index.to_i]
    end
  end

  def self.display_tweet(tweet, index)
    $stdout.puts "\t#{index} - #{tweet.text}"
  end

  def self.safe?(tweet)
    !ruby_cop? || check_ruby_cop(tweet)
  end

  def self.check_ruby_cop(tweet)
    policy = RubyCop::Policy.new
    ast = RubyCop::NodeBuilder.build(tweet)
    ast.accept(policy)
  end

  def self.execute_tweet(tweet)
    text = sanitize_tweet(tweet.text)
    if safe?(text)
      eval(text)
    else
      puts "WARNING: That tweet is trying to do something dangerous!\n\t To remove the safety net, run `twix --naked #{tweet.id}`"
    end
  end

  def self.sanitize_tweet(tweet)
    tweet.gsub(/[”“]/, '"')
      .gsub(/’/, "'")
  end
end
