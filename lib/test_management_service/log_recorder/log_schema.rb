require 'mongoid'

module TestManagementService
  module LogRecorder
    class Log
      include Mongoid::Document
      include Mongoid::Timestamps::Created
      store_in collection: 'maze-logs'

      # A reference describing the kind of log
      field :reference, type: String

      # Data tied to the specific kind of log being recorded, such as device names or IDs
      field :data, type: Hash

      # Contains the url of the buildkite test run
      field :build_url, type: String

      # The timestamp of when the log was generated in the test run
      field :maze_timestamp, type: String
    end
  end
end
