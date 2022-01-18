require "base64"
require "tty-command"

GCLOUD_API_KEYFILE = Base64.decode64(ENV["GCLOUD_API_KEYFILE"])

File.open("/root/.gcloud-api-key.json", "w+") do |f|
  f.write(GCLOUD_API_KEYFILE)
end

IMAGE_REGISTRY_URL = `sh ./app-ci-cd/docker.sh GET_REGISTRY_URL`

puts IMAGE_REGISTRY_URL

cmd = TTY::Command.new
cmd.run("docker login -u _json_key --password-stdin #{IMAGE_REGISTRY_URL} < /root/.gcloud-api-key.json")
