require 'rails_helper'

RSpec.describe TwitterSearcher do
  let(:query) { anything }
  subject(:searcher) { described_class.new(query) }

  context 'initializing the object' do
    it 'configures the query correctly' do
      expect(searcher.query).to eq(query)
    end
  end

  context 'searching' do
    let(:twitter_client) { double(Twitter::REST::Client) }
    let(:tweets) { [anything] }

    before(:each) do
      allow(Twitter::REST::Client).to receive(:new).and_return(twitter_client)
      allow(twitter_client).to receive(:search).and_return(tweets)
    end

    it 'yields a block for all found tweets' do
      expect { |block| searcher.search(&block) }.to yield_successive_args(*tweets)
    end

    it 'returns all found tweets' do
      expect(searcher.search).to match(tweets)
    end
  end

  context 'configuring the client' do
    it 'should create a client' do
      allow(searcher).to receive(:key).and_return(anything.to_s)
      allow(searcher).to receive(:secret).and_return(anything.to_s)

      expect(searcher.send(:client)).to be_an_instance_of(Twitter::REST::Client)
    end
  end

  context 'the environment is missing' do
    it 'raises an exception for a missing key' do
      expect { searcher.send(:key) }.to raise_error(RuntimeError)
    end

    it 'raises an exception for a missing secret' do
      expect { searcher.send(:secret) }.to raise_error(RuntimeError)
    end
  end
end
