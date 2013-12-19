module Eventplug
  class Event < ActiveRecord::Base
    attr_accessible :address, :start_on, :description, :location, :name

    geocoded_by :address
    after_validation :geocode

    belongs_to :owner
    has_many :participants

    validates :name, :presence => true
    validates :start_on, :presence => true

    def description_html
      if not description.blank?
        require 'redcarpet'
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
        html = markdown.render description
      else
        html = I18n.t('eventplug.events.no_description')
      end

      html
    end

    def summary
      ''
    end

    def permalink
      ''
    end

    def to_ics
	  event = Icalendar::Event.new
	  event.start = self.start_on.strftime("%Y%m%dT%H%M%S")
	  event.end = self.end_on.strftime("%Y%m%dT%H%M%S")
	  event.summary = self.name
	  event.description = self.summary
	  event.location = self.location
	  event.klass = "PUBLIC"
	  event.created = self.created_at
	  event.last_modified = self.updated_at
	  event.uid = event.url = self.permalink
	  event.add_comment("")
	  event
    end
  end
end
