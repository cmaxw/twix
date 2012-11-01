require 'twitter'
require 'yaml'

module Twix
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
    handle_switches
    usernames = args.select {|arg| arg.match(/\A@/)}
    user = usernames.first
    show_user_tweets(user) if user
  end

  def self.handle_switches
    true
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
    end
    eval timeline[tweet_index.to_i].text
  end

  def self.display_tweet(tweet, index)
    puts "\t#{index} - #{tweet.text}"
  end
end
