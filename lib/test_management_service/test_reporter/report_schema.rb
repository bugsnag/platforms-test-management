require 'mongoid'

module TestManagementService
  module TestReports
    class Report
      include Mongoid::Document
      include Mongoid::Timestamps::Created
      store_in collection: 'reports'
      field :configuration, type: Hash
      field :build, type: Hash
      field :session, type: Array
    end
  end
end
