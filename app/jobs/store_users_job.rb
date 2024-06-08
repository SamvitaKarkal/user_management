class StoreUsersJob
  include Sidekiq::Job
  require 'net/http'

  def perform
    users_data = fetch_user_data
    male_count, female_count = create_users_and_count(users_data)
    add_gender_count_to_redis(male_count, female_count)
  end

  private

  def fetch_user_data
    uri = URI('https://randomuser.me/api/?results=20')
    response = Net::HTTP.get(uri)
    
    JSON.parse(response)['results']
  end

  def create_users_and_count(users_data)
    male_count = 0
    female_count = 0

    users_data.each do |user_data|
      # replaces user data if user with uuid exists
      user = User.find_or_initialize_by(uuid: user_data['login']['uuid'])
      user.assign_attributes(
        gender: user_data['gender'],
        title: user_data['name']['title'],
        first_name: user_data['name']['first'],
        last_name: user_data['name']['last'],
        email: user_data['email'],
        age: user_data['dob']['age']
      )
      user.save!

      if user_data['gender'] == 'male'
        male_count += 1
      else
        female_count += 1
      end
    end

    [male_count, female_count]
  end

  def add_gender_count_to_redis(male_count, female_count)
    $redis.set('male_count', male_count)
    $redis.set('female_count', female_count)
  end
end
