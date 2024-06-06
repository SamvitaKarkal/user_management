class UsersController < ApplicationController
  def index
    if params[:search]
      search_query = "%#{params[:search]}%"
      @users = User.where('first_name LIKE ? OR last_name LIKE ? OR age::text LIKE ? OR gender LIKE ? OR created_at::text LIKE ?',
                          search_query, search_query, search_query, search_query, search_query)
    else
      @users = User.all
    end
    @user_count = @users.count

    users_data = @users.map do |user|
      user.attributes.transform_keys(&:to_s).merge('created_at' => user.created_at)
    end

    render_liquid_template({'users' => users_data, 'user_count' => @user_count}, 'users/index.liquid')
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    update_daily_record(@user)
    redirect_to users_path
  end

  private

  def update_daily_record(user)
    daily_record = DailyRecord.find_or_create_by(date: Date.today)
    if user.gender == 'male'
      daily_record.male_count -= 1
    else
      daily_record.female_count -= 1
    end
    daily_record.save
  end  
end