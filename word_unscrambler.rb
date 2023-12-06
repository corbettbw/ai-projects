# require 'httparty'

# def send_http_request_and_parse_json(url)
#     response = HTTParty.get(url)
  
#     # Check if the request was successful (HTTP status 2xx)
#     if response.success?
#       json_data = response.parsed_response
#       # Now, json_data contains the parsed JSON response
#       puts "word is #{json_data.first.values.first}"
#     end
# end

# words_checked = 0

# "IBERYETL".split('').permutation.each do |word|
#     url = "https://api.dictionaryapi.dev/api/v2/entries/en/#{word.join}"
#     puts `clear`
#     puts words_checked += 1
#     send_http_request_and_parse_json(url)
# end

ARGV.each_with_index { |argument, index| puts "Argument Number #{index + 1}: #{argument}"}
