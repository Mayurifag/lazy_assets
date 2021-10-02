require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr_cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<FINNHUB_TOKEN>") { FinnhubConfig.api_key }
end
