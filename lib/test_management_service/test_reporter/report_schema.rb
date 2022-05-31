require 'mongoid'

module TestManagementService
  module TestReports
    class Report
      include Mongoid::Document
      include Mongoid::Timestamps::Created
      store_in collection: 'reports'

      # Configuration contains maze-runner specific details including:
      # - Device farm used
      # - Requested device including OS and OS version
      # - Appium driver being used
      field :configuration, type: Hash

      # Build contains Buildkite and Git details including:
      # - Pipeline
      # - Repo
      # - Commit branch, hash, and message
      field :build, type: Hash

      # Contains each test run within the test session as output by the Cucumber JSON formatter
      field :session, type: Array
    end
  end
end
