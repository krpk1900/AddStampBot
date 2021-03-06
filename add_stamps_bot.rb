require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['BOT_USER_TOKEN']
end

client = Slack::Web::Client.new
# チャンネルIDを入れて使う
channels = ['C01JX3FMM9B', 'C010MLDEXJN', 'CL70X699R']

stumps = ['+1', 'emoji_sugoi', 'emoji_otsukare', 'iine_', 'ileiilei', 'gannbare', 'daijoubu', 'wakaru', 'fire', 'ganbaro',
          'yoi', 'sorena', 'among_us', 'yokatta', 'tasikani', 'hayaine', 'yabatanienn', 'tuyotuyo', 'tasukete', 'kowaiyo',
          'yabasou', 'annoying_dog', 'nanikore']

for channel in channels do
  messages = client.conversations_history(channel: channel, limit: 10)['messages']
  for message in messages do
    timestamp = message['ts']
    stumps.shuffle!
    for stump in stumps do
      begin
        client.reactions_add(channel: channel, name: stump, timestamp: timestamp)
      rescue => e
      end
    end
  end
end
