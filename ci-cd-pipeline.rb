require 'aws-sdk'
require 'optparse'

@client = Aws::SSM::Client.new

options[:app_name] = 'dashboard'
options[:environment] = 'staging'

def get_parameters(parameters = [], next_token)
   path = "/#{options[:environment]}/#{options[:app_name]}"
 
   res = @client.get_parameters_by_path({
     path: path,
     recursive: true,
     next_token: next_token
   })
 
   parameters.concat res[:parameters]
 
   return parameters unless res[:next_token]
 
   get_parameters(parameters, res[:next_token])
end

puts get_parameters
# @options = {}

# OptionParser.new do |opts|
# end
