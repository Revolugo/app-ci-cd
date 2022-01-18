require "base64"

content = File.read('Input.txt')
content.gsub!('\\r', "\r")
content.gsub!('\\n', "\n")
decode_base64_content = Base64.decode64(ENV["GCLOUD_API_KEYFILE"])
puts '==================================='
puts decode_base64_content
puts '==================================='
File.open("~/.gcloud-api-key.json", "wb") do |f|
  f.write(decode_base64_content)
end

IMAGE_REGISTRY_URL=$( sh ./app-ci-cd/docker.sh GET_REGISTRY_URL )

puts IMAGE_REGISTRY_URL
