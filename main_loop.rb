@data = []
@last_date = 0;

loop do

  p 'loop...'

  now = Time.now.strftime("%Y-%m-%d")

  if now != @last_date then
    @data = []
  end

  uri = URI.parse('https://api.hipchat.com/v1/rooms/history?room_id=' + $config['hipchatRoom'] + '&date=' + now + '&timezone=JST&format=json&auth_token=' + $config['hipchatToken'])
  json = Net::HTTP.get(uri)
  result = JSON.parse(json)['messages']

  news = result - @data
  pp news

  news.each do |new|
    system('curl -X POST -H "X-ChatWorkToken: ' + $config['chatworkToken'] + '" -d "body=' + new['from']['name'] + ': ' + new['message'] + '" "https://api.chatwork.com/v1/rooms/' + $config['chatworkRoom'] + '/messages"')
  end

  @last_date = now
  @data      = result

  sleep 10
end
