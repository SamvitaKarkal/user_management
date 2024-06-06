class DailyRecord < ApplicationRecord
  after_save :calculate_average_ages, if: :counts_changed?

  private

  def counts_changed?
    saved_changes.key?('male_count') || saved_changes.key?('female_count')
  end

  def calculate_average_ages
    male_avg_age = User.where(gender: 'male').average(:age).to_i
    female_avg_age = User.where(gender: 'female').average(:age).to_i

    update_columns(male_avg_age: male_avg_age, female_avg_age: female_avg_age)
  end
end
