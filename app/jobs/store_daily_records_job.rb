class StoreDailyRecordsJob
  include Sidekiq::Job

  def perform
    male_count = $redis.get('male_count').to_i
    female_count = $redis.get('female_count').to_i

    DailyRecord.create(
      date: Date.today,
      male_count: male_count,
      female_count: female_count
    )

    $redis.set('male_count', 0)
    $redis.set('female_count', 0)
  end
end
