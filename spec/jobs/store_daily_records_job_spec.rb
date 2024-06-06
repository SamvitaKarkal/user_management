require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe StoreDailyRecordsJob, type: :job do
  describe "#perform" do
    before do
      # Stubbing Redis
      allow($redis).to receive(:get).with('male_count').and_return('3')
      allow($redis).to receive(:get).with('female_count').and_return('2')

      # Stubbing Redis set method
      allow($redis).to receive(:set)
    end

    it "creates a new DailyRecord with correct male and female counts" do
      expect {
        StoreDailyRecordsJob.new.perform
      }.to change { DailyRecord.count }.by(1)

      daily_record = DailyRecord.last
      expect(daily_record.date).to eq(Date.today)
      expect(daily_record.male_count).to eq(3)
      expect(daily_record.female_count).to eq(2)
    end

    it "resets male and female counts in Redis to 0" do
      StoreDailyRecordsJob.new.perform

      expect($redis).to have_received(:set).with('male_count', 0)
      expect($redis).to have_received(:set).with('female_count', 0)
    end
  end
end
