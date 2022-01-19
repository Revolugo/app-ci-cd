require 'aws-sdk'
require 'optparse'

@client = Aws::SSM::Client.new

@options = {}

@app_name = 'dashboard'
@environment = 'staging'

OptionParser.new do |opts|
   opts.on("-t TAG", "--tag TAG", "Image Tag") do |val|
      @options[:image_tag] = val
   end

   opts.on("--fetch-parameter-store PARAMETER_STORE", "Fetch parameter store for env vars") do |val|
      @options[:fetch_parameter_store] = val
   end
 end.parse!

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

puts @options[:fetch_parameter_store]

if @options[:fetch_parameter_store] == 'true'
   puts get_parameters
end

puts Dir.pwd
   # @options = {}

# OptionParser.new do |opts|
# end
