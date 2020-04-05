#!/usr/bin/env ruby

require 'pp' # TODO drop
require 'cli'

opts = CLI.new do
  description 'Fetches dog breed image links from dog API. See Readme.md for more.'
  version '0.0.1'
  arguments :breeds, description: 'Comma separated list of breeds. Sub-breeds follow separated by a dash, eg. bulldog-boston'
end.parse!

pp opts.breeds # TODO drop

breed_names = opts.breeds.map do |breed_name|
  breed_name.tr(',','')
  # TODO URL sanitization
end.reject!(&:empty?)

breeds_from_api = BreedsApi.fetch_breeds(breed_names)
BreedsStorage.save(breeds_from_api)