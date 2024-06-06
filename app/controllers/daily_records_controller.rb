class DailyRecordsController < ApplicationController
  def index
    @daily_records = DailyRecord.all

    daily_records = @daily_records.map do |record|
      record.attributes.transform_keys(&:to_s)
    end

    render_liquid_template({'daily_records' => daily_records}, 'daily_records/index.liquid')
  end
end
