class TwitterSearcher
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def search(&block)
    results = client.search(query, count: 100, result_type: 'recent')
    results.each(&block) if block_given?
    results
  end

  private

  def client
    @client ||= twitter_client
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key    = key
      config.consumer_secret = secret
    end
  end

  def key
    @key ||= ENV.fetch('TWITTER_API_CONSUMER_KEY') do
      fail "ENV['TWITTER_API_CONSUMER_KEY'] not defined!"
    end
  end

  def secret
    @secret ||= ENV.fetch('TWITTER_API_CONSUMER_SECRET') do
      fail "ENV['TWITTER_API_CONSUMER_KEY'] not defined!"
    end
  end
end
