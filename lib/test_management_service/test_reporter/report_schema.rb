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

      # accepts_nested_attributes_for :configuration, :build, :session
    end

  #   class Configuration
  #     include Mongoid::Document

  #     belongs_to :report, class_name: 'Report', inverse_of: :configuration
  #     field :driver_class, type: String
  #     field :device_farm, type: String
  #     field :device, type: String
  #     field :os, type: String
  #     field :os_version, type: String
  #   end

  #   class Build
  #     include Mongoid::Document

  #     belongs_to :report, class_name: 'Report', inverse_of: :build
  #     field :pipeline, type: String
  #     field :repo, type: String
  #     field :build_url, type: String
  #     field :branch, type: String
  #     field :message, type: String
  #     field :step, type: String
  #     field :commit, type: String
  #   end

  #   class Session
  #     include Mongoid::Document

  #     belongs_to :report, class_name: 'Report', inverse_of: :session
  #     unalias_attribute :id
  #     field :id, type: String
  #     field :uri, type: String
  #     field :keyword, type: String
  #     field :name, type: String
  #     field :description, type: String
  #     field :line, type: Integer
  #     has_many :elements, class_name: 'Element', inverse_of: :session

  #     accepts_nested_attributes_for :elements
  #   end

  #   class Element
  #     include Mongoid::Document

  #     belongs_to :session, class_name: 'Session', inverse_of: :element
  #     unalias_attribute :id
  #     field :id, type: String
  #     field :keyword, type: String
  #     field :name, type: String
  #     field :description, type: String
  #     field :line, type: Integer
  #     field :type, type: String
  #     has_many :steps, class_name: 'Step', inverse_of: :element
  #     has_many :before, class_name: 'Before', inverse_of: :element
  #     has_many :after, class_name: 'After', inverse_of: :element

  #     accepts_nested_attributes_for :steps, :before, :after
  #   end

  #   class Step
  #     include Mongoid::Document

  #     belongs_to :element, class_name: 'Element', inverse_of: :steps
  #     field :keyword, type: String
  #     field :name, type: String
  #     field :line, type: Integer
  #     field :rows, type: Array
  #     field :match, type: Hash
  #     field :result, type: Hash
  #   end

  #   class Before
  #     include Mongoid::Document

  #     belongs_to :element, class_name: 'Element', inverse_of: :before
  #     field :match, type: Hash
  #     field :result, type: Hash
  #   end

  #   class After
  #     include Mongoid::Document

  #     belongs_to :element, class_name: 'Element', inverse_of: :after
  #     field :match, type: Hash
  #     field :result, type: Hash
  #   end
  end
end
