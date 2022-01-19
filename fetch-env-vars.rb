require 'aws-sdk'
require 'optparse'

@client = Aws::SSM::Client.new

@options = {}

@app_name = ARGV[0]
@environment = ARGV[1]

def get_parameters(parameters = [], next_token = nil)
   path = "/#{@environment}/#{@app_name}"
 
   res = @client.get_parameters_by_path({
     path: path,
     recursive: true,
     next_token: next_token
   })
 
   parameters.concat res[:parameters]
 
   return parameters unless res[:next_token]
 
   get_parameters(parameters, res[:next_token])
end

env_vars = get_parameters.map do |val|
   "#{val['name'].split('/')[3]}=#{val['value']}"
end

if env_vars.empty?
   puts "⚠️  No env vars found for app: #{@app_name} on environment: #{@environment}" 
end

File.write("../.env", env_vars.join("\n"), mode: "w")
