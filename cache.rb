require 'excon'

rfcs = []

# http 1.1
rfcs.concat((7230..7237).to_a)

# http 2.0
rfcs.concat([7540])

etags = {}

rfcs.each do |rfc|
  puts "caching #{rfc}"
  response = Excon.get("https://tools.ietf.org/html/rfc#{rfc}")
  etags[rfc] = response.headers['etag']
  File.open("./rfcs/rfc#{rfc}.html", "w") {|file| file.puts(response.body)}
end
