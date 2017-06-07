class StatsController < ApplicationController

  before_action :authenticate_user!

  def new
  end

  def create
    Stat.create(date:create_params[:date],used_korean:create_params[:used_korean],korean_learning:create_params[:korean_learning],politic_learning:create_params[:politic_learning],roll_calling:create_params[:roll_calling],morning_meeting:create_params[:morning_meeting],attendance:create_params[:attendance],reviewing:create_params[:reviewing],study_time:create_params[:study_time],korean_books:create_params[:korean_books],other_books:create_params[:other_books],room_cleaning:create_params[:room_cleaning],campus_cleaning:create_params[:campus_cleaning],night_roll_calling:create_params[:night_roll_calling],group_num:current_user.year.to_s + current_user.group_id.to_s, user_id:current_user.id, year_num:current_user.year)

    redirect_to :controller => "users", :action => "show", :id => current_user.id
  end

  def index
    d = Date.today
    @stats_today = Stat.joins(:user).includes(:user).where(date: d).order("users.year,users.group_id")
    @stats_yesterday = Stat.joins(:user).includes(:user).where(date: d - 1).order("users.year,users.group_id")

    @users = User.all
    @t_stats =Stat.joins(:user).includes(:user).where(date: d).order("users.year,users.group_id").group(:group_num)
    @y_stats =Stat.joins(:user).includes(:user).where(date: d - 1).order("users.year,users.group_id").group(:group_num)


    stats_ave_today =  Stat.joins(:user).includes(:user).where(date: d).order("users.year,users.group_id").group(:group_num)

      @study_time_t =[]
      stats_ave_today.each do |ave|
        ave = Stat.where(date: d).where(group_num: ave.group_num).select(:study_time).average(:study_time)
      @study_time_t << ave.round(1)
      end

      @korean_books_t =[]
      stats_ave_today.each do |ave|
        ave = Stat.where(date: d).where(group_num: ave.group_num).select(:korean_books).average(:korean_books)
      @korean_books_t << ave.round(1)
      end

      @other_books_t =[]
      stats_ave_today.each do |ave|
        ave = Stat.where(date: d).where(group_num: ave.group_num).select(:other_books).average(:other_books)
      @other_books_t << ave.round(1)
      end


      @used_korean_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).select(:used_korean).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(used_korean: "ㄱ").select(:used_korean).count
        if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @used_korean_t << percent
      end

      @korean_learning_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(korean_learning = ?) OR (korean_learning = ?)", "◯", "X").select(:korean_learning).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(korean_learning: "◯").select(:korean_learning).count
        if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @korean_learning_t << percent
      end

      @politic_learning_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(politic_learning = ?) OR (politic_learning = ?)", "◯", "X").select(:politic_learning).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(politic_learning: "◯").select(:politic_learning).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @politic_learning_t << percent
      end

      @roll_calling_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(roll_calling = ?) OR (roll_calling = ?)", "◯", "X").select(:roll_calling).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(roll_calling: "◯").select(:roll_calling).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @roll_calling_t << percent
      end

      @morning_meeting_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(morning_meeting = ?) OR (morning_meeting = ?)", "◯", "X").select(:morning_meeting).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(morning_meeting: "◯").select(:morning_meeting).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @morning_meeting_t << percent
      end

      @attendance_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(attendance = ?) OR (attendance = ?)", "◯", "X").select(:attendance).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(attendance: "◯").select(:attendance).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @attendance_t << percent
      end

      @reviewing_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(reviewing = ?) OR (reviewing = ?)", "◯", "X").select(:reviewing).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(reviewing: "◯").select(:reviewing).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @reviewing_t << percent
      end

      @room_cleaning_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(room_cleaning = ?) OR (room_cleaning = ?)", "◯", "X").select(:room_cleaning).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(room_cleaning: "◯").select(:room_cleaning).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @room_cleaning_t << percent
      end

      @campus_cleaning_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(campus_cleaning = ?) OR (campus_cleaning = ?)", "◯", "X").select(:campus_cleaning).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(campus_cleaning: "◯").select(:campus_cleaning).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @campus_cleaning_t << percent
      end

      @night_roll_calling_t = []
      stats_ave_today.each do |ave|
        all_count = Stat.where(date: d).where(group_num: ave.group_num).where("(night_roll_calling = ?) OR (night_roll_calling = ?)", "◯", "X").select(:night_roll_calling).count
        good_count = Stat.where(date: d).where(group_num: ave.group_num).where(night_roll_calling: "◯").select(:night_roll_calling).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @night_roll_calling_t << percent
      end





      stats_ave_yesterday =  Stat.joins(:user).includes(:user).where(date: d - 1).order("users.year,users.group_id").group(:group_num)

      @study_time_y =[]
      stats_ave_yesterday.each do |ave|
        ave = Stat.where(date: d - 1).where(group_num: ave.group_num).select(:study_time).average(:study_time)
      @study_time_y << ave.round(1)
      end

      @korean_books_y =[]
      stats_ave_yesterday.each do |ave|
        ave = Stat.where(date: d - 1).where(group_num: ave.group_num).select(:korean_books).average(:korean_books)
      @korean_books_y << ave.round(1)
      end

      @other_books_y =[]
      stats_ave_yesterday.each do |ave|
        ave = Stat.where(date: d - 1).where(group_num: ave.group_num).select(:other_books).average(:other_books)
      @other_books_y << ave.round(1)
      end


      @used_korean_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).select(:used_korean).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(used_korean: "ㄱ").select(:used_korean).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @used_korean_y << percent
      end

      @korean_learning_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(korean_learning = ?) OR (korean_learning = ?)", "◯", "X").select(:korean_learning).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(korean_learning: "◯").select(:korean_learning).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @korean_learning_y << percent
      end

      @politic_learning_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(politic_learning = ?) OR (politic_learning = ?)", "◯", "X").select(:politic_learning).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(politic_learning: "◯").select(:politic_learning).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @politic_learning_y << percent
      end

      @roll_calling_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(roll_calling = ?) OR (roll_calling = ?)", "◯", "X").select(:roll_calling).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(roll_calling: "◯").select(:roll_calling).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @roll_calling_y << percent
      end

      @morning_meeting_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(morning_meeting = ?) OR (morning_meeting = ?)", "◯", "X").select(:morning_meeting).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(morning_meeting: "◯").select(:morning_meeting).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @morning_meeting_y << percent
      end

      @attendance_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(attendance = ?) OR (attendance = ?)", "◯", "X").select(:attendance).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(attendance: "◯").select(:attendance).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @attendance_y << percent
      end

      @reviewing_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(reviewing = ?) OR (reviewing = ?)", "◯", "X").select(:reviewing).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(reviewing: "◯").select(:reviewing).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @reviewing_y << percent
      end

      @room_cleaning_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(room_cleaning = ?) OR (room_cleaning = ?)", "◯", "X").select(:room_cleaning).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(room_cleaning: "◯").select(:room_cleaning).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @room_cleaning_y << percent
      end

      @campus_cleaning_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(campus_cleaning = ?) OR (campus_cleaning = ?)", "◯", "X").select(:campus_cleaning).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(campus_cleaning: "◯").select(:campus_cleaning).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @campus_cleaning_y << percent
      end

      @night_roll_calling_y = []
      stats_ave_yesterday.each do |ave|
        all_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where("(night_roll_calling = ?) OR (night_roll_calling = ?)", "◯", "X").select(:night_roll_calling).count
        good_count = Stat.where(date: d - 1).where(group_num: ave.group_num).where(night_roll_calling: "◯").select(:night_roll_calling).count
                if all_count == 0
        percent = 100
        else
        percent = good_count * 100 / all_count
        end
        @night_roll_calling_y << percent
      end


     unless @stats_today.empty?
     stats_count_t = @stats_today.count.to_i
     chibu1 = @stats_today.select {|item| item.used_korean  == "ㄱ" || item.used_korean == "ㄴ"}.length
     if chibu1 == 0
     @chibu_uk_y = 0
     else
     @chibu_uk_t = chibu1 * 100 / stats_count_t
     end

     chibu2 = @stats_today.select {|item| item.korean_learning  == "◯" }.length
     chibu2_a = @stats_today.select {|item| item.korean_learning  == "◯" || item.korean_learning == "X" }.length
      if chibu2_a == 0
     @chibu_kl_y = 100
      else
     @chibu_kl_t = chibu2 * 100 / chibu2_a
      end

     chibu3 = @stats_today.select {|item| item.roll_calling  == "◯" }.length
     chibu3_a = @stats_today.select {|item| item.roll_calling  == "◯" || item.roll_calling == "X" }.length
     if chibu3_a == 0
     @chibu_kl_y = 100
      else
     @chibu_mr_t = chibu3 * 100 / chibu3_a
     end

     chibu4 = @stats_today.select {|item| item.night_roll_calling  == "◯" }.length
     chibu4_a = @stats_today.select {|item| item.night_roll_calling  == "◯" || item.night_roll_calling == "X" }.length
     if chibu4_a == 0
     @chibu_kl_y = 100
      else
     @chibu_nr_t = chibu4 * 100 / chibu4_a
     end

     chibu5 = @stats_today.select {|item| item.morning_meeting  == "◯" }.length
     chibu5_a = @stats_today.select {|item| item.morning_meeting  == "◯" || item.morning_meeting == "X" }.length
     if chibu5_a == 0
     @chibu_kl_y = 100
      else
     @chibu_mm_t = chibu5 * 100 / chibu5_a
     end

     chibu6 = @stats_today.select {|item| item.attendance  == "◯" }.length
     chibu6_a = @stats_today.select {|item| item.attendance  == "◯" || item.attendance == "X" }.length
     if chibu6_a == 0
     @chibu_kl_y = 100
      else
     @chibu_at_t = chibu6 * 100 / chibu6_a
     end

     chibu7 = @stats_today.select {|item| item.politic_learning  == "◯" }.length
     chibu7_a = @stats_today.select {|item| item.politic_learning  == "◯" || item.politic_learning == "X" }.length
     if chibu7_a == 0
     @chibu_kl_y = 100
      else
     @chibu_pl_t = chibu7 * 100 / chibu7_a
     end

     chibu8 = @stats_today.select {|item| item.reviewing  == "◯" }.length
     chibu8_a = @stats_today.select {|item| item.reviewing  == "◯" || item.reviewing == "X" }.length
     if chibu8_a == 0
     @chibu_kl_y = 100
      else
     @chibu_re_t = chibu8 * 100 / chibu8_a
     end

     chibu9 = @stats_today.select {|item| item.campus_cleaning  == "◯" }.length
     chibu9_a = @stats_today.select {|item| item.campus_cleaning  == "◯" || item.campus_cleaning == "X" }.length
     if chibu9_a == 0
     @chibu_kl_y = 100
      else
     @chibu_cc_t = chibu9 * 100 / chibu9_a
     end

     chibu10 = @stats_today.select {|item| item.room_cleaning  == "◯" }.length
     chibu10_a = @stats_today.select {|item| item.room_cleaning  == "◯" || item.room_cleaning == "X" }.length
     if chibu10_a == 0
     @chibu_kl_y = 100
      else
     @chibu_rc_t = chibu10 * 100 / chibu10_a
     end
     end


     unless @stats_yesterday.empty?
     stats_count_t = @stats_yesterday.count.to_i
     chibu1 = @stats_yesterday.select {|item| item.used_korean  == "ㄱ" || item.used_korean == "ㄴ"}.length
     if chibu1 == 0
     @chibu_uk_y = 0
     else
     @chibu_uk_y = chibu1 * 100 / stats_count_t
     end

     chibu2 = @stats_yesterday.select {|item| item.korean_learning  == "◯" }.length
     chibu2_a = @stats_yesterday.select {|item| item.korean_learning  == "◯" || item.korean_learning == "X" }.length
      if chibu2_a == 0
     @chibu_kl_y = 100
      else
     @chibu_kl_y = chibu2 * 100 / chibu2_a
      end

     chibu3 = @stats_yesterday.select {|item| item.roll_calling  == "◯" }.length
     chibu3_a = @stats_yesterday.select {|item| item.roll_calling  == "◯" || item.roll_calling == "X" }.length
     if chibu3_a == 0
     @chibu_mr_y = 100
     else
     @chibu_mr_y = chibu3 * 100 / chibu3_a
     end


     chibu4 = @stats_yesterday.select {|item| item.night_roll_calling  == "◯" }.length
     chibu4_a = @stats_yesterday.select {|item| item.night_roll_calling  == "◯" || item.night_roll_calling == "X" }.length
     if chibu4_a == 0
     @chibu_nr_y = 100
     else
     @chibu_nr_y = chibu4 * 100 / chibu4_a
     end

     chibu5 = @stats_yesterday.select {|item| item.morning_meeting  == "◯" }.length
     chibu5_a = @stats_yesterday.select {|item| item.morning_meeting  == "◯" || item.morning_meeting == "X" }.length
     if chibu5_a == 0
     @chibu_mm_y = 100
     else
     @chibu_mm_y = chibu5 * 100 / chibu5_a
     end

     chibu6 = @stats_yesterday.select {|item| item.attendance  == "◯" }.length
     chibu6_a = @stats_yesterday.select {|item| item.attendance  == "◯" || item.attendance == "X" }.length
    if chibu6_a == 0
     @chibu_kl_y = 100
     else
     @chibu_at_y = chibu6 * 100 / chibu6_a
     end

     chibu7 = @stats_yesterday.select {|item| item.politic_learning  == "◯" }.length
     chibu7_a = @stats_yesterday.select {|item| item.politic_learning  == "◯" || item.politic_learning == "X" }.length
     if chibu7_a == 0
     @chibu_pl_y = 100
     else
     @chibu_pl_y = chibu7 * 100 / chibu7_a
     end

     chibu8 = @stats_yesterday.select {|item| item.reviewing  == "◯" }.length
     chibu8_a = @stats_yesterday.select {|item| item.reviewing  == "◯" || item.reviewing == "X" }.length
     if chibu8_a == 0
     @chibu_re_y = 100
     else
     @chibu_re_y = chibu8 * 100 / chibu8_a
     end

     chibu9 = @stats_yesterday.select {|item| item.campus_cleaning  == "◯" }.length
     chibu9_a = @stats_yesterday.select {|item| item.campus_cleaning  == "◯" || item.campus_cleaning == "X" }.length
     if chibu9_a == 0
     @chibu_cc_y = 100
     else
     @chibu_cc_y = chibu9 * 100 / chibu9_a
     end

     chibu10 = @stats_yesterday.select {|item| item.room_cleaning  == "◯" }.length
     chibu10_a = @stats_yesterday.select {|item| item.room_cleaning  == "◯" || item.room_cleaning == "X" }.length
     if chibu10_a == 0
     @chibu_rc_y = 100
     else
     @chibu_rc_y = chibu10 * 100 / chibu10_a
     end
     end

  end

  def analytics
    @korean_books_stats = Stat.joins(:user).includes(:user).group("users.nickname").order("users.year,users.group_id").sum(:korean_books)
    @other_books_stats = Stat.joins(:user).includes(:user).group("users.nickname").order("users.year,users.group_id").sum(:other_books)


    d = Date.today

    @study_time_ranking = Stat.joins(:user).includes(:user).where(date: d - 1).order("study_time DESC").limit(6)
    @korean_books_ranking = Stat.joins(:user).includes(:user).where(date: d - 1).order("korean_books DESC").limit(6)
    @other_books_ranking = Stat.joins(:user).includes(:user).where(date: d - 1).order("other_books DESC").limit(6)
  end


  def weeks
     @before_manday = 0.days.ago.prev_week.strftime("%Y-%m-%d")
     @before_friday = 0.days.ago.prev_week(:friday).strftime("%Y-%m-%d")
     @stats_weeks_1 = Stat.where(date: @before_manday..@before_friday).where(year_num: 1)
     @stats_weeks_2 = Stat.where(date: @before_manday..@before_friday).where(year_num: 2)
     @stats_weeks_3 = Stat.where(date: @before_manday..@before_friday).where(year_num: 3)
     @stats_weeks_4 = Stat.where(date: @before_manday..@before_friday).where(year_num: 4)

     unless @stats_weeks_1.empty?
     stats_count_t = @stats_weeks_1.count.to_i
     pan_1_k = @stats_weeks_1.select {|item| item.used_korean  == "ㄱ"}.length
     pan_1_n = @stats_weeks_1.select {|item| item.used_korean  == "ㄴ"}.length
     pan_1_t = @stats_weeks_1.select {|item| item.used_korean  == "ㄷ"}.length
     pan_1_r = @stats_weeks_1.select {|item| item.used_korean  == "ㄹ"}.length
     if stats_count_t == 0
     @pan_1_uk_t_k = 0
     @pan_1_uk_t_n = 0
     @pan_1_uk_t_t = 0
     @pan_1_uk_t_r = 0
     else
     @pan_1_uk_t_k = pan_1_k * 100 / stats_count_t
     @pan_1_uk_t_n = pan_1_n * 100 / stats_count_t
     @pan_1_uk_t_t = pan_1_t * 100 / stats_count_t
     @pan_1_uk_t_r = pan_1_r * 100 / stats_count_t
     end

     pan_3 = @stats_weeks_1.select {|item| item.roll_calling  == "◯" }.length
     pan_3_a = @stats_weeks_1.select {|item| item.roll_calling  == "◯" || item.roll_calling == "X" }.length
     if pan_3_a == 0
     @pan_1_mr_t = 100
      else
     @pan_1_mr_t = pan_3 * 100 / pan_3_a
     end

     pan_4 = @stats_weeks_1.select {|item| item.night_roll_calling  == "◯" }.length
     pan_4_a = @stats_weeks_1.select {|item| item.night_roll_calling  == "◯" || item.night_roll_calling == "X" }.length
     if pan_4_a == 0
     @pan_1_nr_t = 100
      else
     @pan_1_nr_t = pan_4 * 100 / pan_4_a
     end

     pan5 = @stats_weeks_1.select {|item| item.morning_meeting  == "◯" }.length
     pan_5_a = @stats_weeks_1.select {|item| item.morning_meeting  == "◯" || item.morning_meeting == "X" }.length
     if pan_5_a == 0
     @pan_1_mm_t = 100
      else
     @pan_1_mm_t = pan5 * 100 / pan_5_a
     end

     pam_6 = @stats_weeks_1.select {|item| item.attendance  == "◯" }.length
     pan_6_a = @stats_weeks_1.select {|item| item.attendance  == "◯" || item.attendance == "X" }.length
     if pan_6_a == 0
     @pan_1_at_t = 100
      else
     @pan_1_at_t = pam_6 * 100 / pan_6_a
     end

     pan7 = @stats_weeks_1.select {|item| item.politic_learning  == "◯" }.length
     pan7_a = @stats_weeks_1.select {|item| item.politic_learning  == "◯" || item.politic_learning == "X" }.length
     if pan7_a == 0
     @pan_1_pl_t = 100
      else
     @pan_1_pl_t = pan7 * 100 / pan7_a
     end

     pan8 = @stats_weeks_1.select {|item| item.reviewing  == "◯" }.length
     pan8_a = @stats_weeks_1.select {|item| item.reviewing  == "◯" || item.reviewing == "X" }.length
     if pan8_a == 0
     @pan_1_re_t = 100
      else
     @pan_1_re_t = pan8 * 100 / pan8_a
     end

     pan9 = @stats_weeks_1.select {|item| item.campus_cleaning  == "◯" }.length
     pan9_a = @stats_weeks_1.select {|item| item.campus_cleaning  == "◯" || item.campus_cleaning == "X" }.length
     if pan9_a == 0
     @pan_1_cc_t = 100
      else
     @pan_1_cc_t = pan9 * 100 / pan9_a
     end

     pan10 = @stats_weeks_1.select {|item| item.room_cleaning  == "◯" }.length
     pan10_a = @stats_weeks_1.select {|item| item.room_cleaning  == "◯" || item.room_cleaning == "X" }.length
     if pan10_a == 0
     @pan_1_rc_t = 100
      else
     @pan_1_rc_t = pan10 * 100 / pan10_a
     end
     end

     unless @stats_weeks_2.empty?
     stats_count_t = @stats_weeks_2.count.to_i
     pan_2_k = @stats_weeks_2.select {|item| item.used_korean  == "ㄱ"}.length
     pan_2_n = @stats_weeks_2.select {|item| item.used_korean  == "ㄴ"}.length
     pan_2_t = @stats_weeks_2.select {|item| item.used_korean  == "ㄷ"}.length
     pan_2_r = @stats_weeks_2.select {|item| item.used_korean  == "ㄹ"}.length
     if stats_count_t == 0
     @pan_2_uk_t_k = 0
     @pan_2_uk_t_n = 0
     @pan_2_uk_t_t = 0
     @pan_2_uk_t_r = 0
     else
     @pan_2_uk_t_k = pan_2_k * 100 / stats_count_t
     @pan_2_uk_t_n = pan_2_n * 100 / stats_count_t
     @pan_2_uk_t_t = pan_2_t * 100 / stats_count_t
     @pan_2_uk_t_r = pan_2_r * 100 / stats_count_t
     end

     pan_3 = @stats_weeks_2.select {|item| item.roll_calling  == "◯" }.length
     pan_3_a = @stats_weeks_2.select {|item| item.roll_calling  == "◯" || item.roll_calling == "X" }.length
     if pan_3_a == 0
     @pan_2_mr_t = 100
      else
     @pan_2_mr_t = pan_3 * 100 / pan_3_a
     end

     pan_4 = @stats_weeks_2.select {|item| item.night_roll_calling  == "◯" }.length
     pan_4_a = @stats_weeks_2.select {|item| item.night_roll_calling  == "◯" || item.night_roll_calling == "X" }.length
     if pan_4_a == 0
     @pan_2_nr_t = 100
      else
     @pan_2_nr_t = pan_4 * 100 / pan_4_a
     end

     pan5 = @stats_weeks_2.select {|item| item.morning_meeting  == "◯" }.length
     pan_5_a = @stats_weeks_2.select {|item| item.morning_meeting  == "◯" || item.morning_meeting == "X" }.length
     if pan_5_a == 0
     @pan_2_mm_t = 100
      else
     @pan_2_mm_t = pan5 * 100 / pan_5_a
     end

     pam_6 = @stats_weeks_2.select {|item| item.attendance  == "◯" }.length
     pan_6_a = @stats_weeks_2.select {|item| item.attendance  == "◯" || item.attendance == "X" }.length
     if pan_6_a == 0
     @pan_2_at_t = 100
      else
     @pan_2_at_t = pam_6 * 100 / pan_6_a
     end

     pan7 = @stats_weeks_2.select {|item| item.politic_learning  == "◯" }.length
     pan7_a = @stats_weeks_2.select {|item| item.politic_learning  == "◯" || item.politic_learning == "X" }.length
     if pan7_a == 0
     @pan_2_pl_t = 100
      else
     @pan_2_pl_t = pan7 * 100 / pan7_a
     end

     pan8 = @stats_weeks_2.select {|item| item.reviewing  == "◯" }.length
     pan8_a = @stats_weeks_2.select {|item| item.reviewing  == "◯" || item.reviewing == "X" }.length
     if pan8_a == 0
     @pan_2_re_t = 100
      else
     @pan_2_re_t = pan8 * 100 / pan8_a
     end

     pan9 = @stats_weeks_2.select {|item| item.campus_cleaning  == "◯" }.length
     pan9_a = @stats_weeks_2.select {|item| item.campus_cleaning  == "◯" || item.campus_cleaning == "X" }.length
     if pan9_a == 0
     @pan_2_cc_t = 100
      else
     @pan_2_cc_t = pan9 * 100 / pan9_a
     end

     pan10 = @stats_weeks_2.select {|item| item.room_cleaning  == "◯" }.length
     pan10_a = @stats_weeks_2.select {|item| item.room_cleaning  == "◯" || item.room_cleaning == "X" }.length
     if pan10_a == 0
     @pan_2_rc_t = 100
      else
     @pan_2_rc_t = pan10 * 100 / pan10_a
     end
     end

     unless @stats_weeks_3.empty?
     stats_count_t = @stats_weeks_3.count.to_i
     pan_3_k = @stats_weeks_3.select {|item| item.used_korean  == "ㄱ"}.length
     pan_3_n = @stats_weeks_3.select {|item| item.used_korean  == "ㄴ"}.length
     pan_3_t = @stats_weeks_3.select {|item| item.used_korean  == "ㄷ"}.length
     pan_3_r = @stats_weeks_3.select {|item| item.used_korean  == "ㄹ"}.length
     if stats_count_t == 0
     @pan_3_uk_t_k = 0
     @pan_3_uk_t_n = 0
     @pan_3_uk_t_t = 0
     @pan_3_uk_t_r = 0
     else
     @pan_3_uk_t_k = pan_3_k * 100 / stats_count_t
     @pan_3_uk_t_n = pan_3_n * 100 / stats_count_t
     @pan_3_uk_t_t = pan_3_t * 100 / stats_count_t
     @pan_3_uk_t_r = pan_3_r * 100 / stats_count_t
     end

     pan_3 = @stats_weeks_3.select {|item| item.roll_calling  == "◯" }.length
     pan_3_a = @stats_weeks_3.select {|item| item.roll_calling  == "◯" || item.roll_calling == "X" }.length
     if pan_3_a == 0
     @pan_3_mr_t = 100
      else
     @pan_3_mr_t = pan_3 * 100 / pan_3_a
     end

     pan_4 = @stats_weeks_3.select {|item| item.night_roll_calling  == "◯" }.length
     pan_4_a = @stats_weeks_3.select {|item| item.night_roll_calling  == "◯" || item.night_roll_calling == "X" }.length
     if pan_4_a == 0
     @pan_3_nr_t = 100
      else
     @pan_3_nr_t = pan_4 * 100 / pan_4_a
     end

     pan5 = @stats_weeks_3.select {|item| item.morning_meeting  == "◯" }.length
     pan_5_a = @stats_weeks_3.select {|item| item.morning_meeting  == "◯" || item.morning_meeting == "X" }.length
     if pan_5_a == 0
     @pan_3_mm_t = 100
      else
     @pan_3_mm_t = pan5 * 100 / pan_5_a
     end

     pam_6 = @stats_weeks_3.select {|item| item.attendance  == "◯" }.length
     pan_6_a = @stats_weeks_3.select {|item| item.attendance  == "◯" || item.attendance == "X" }.length
     if pan_6_a == 0
     @pan_3_at_t = 100
      else
     @pan_3_at_t = pam_6 * 100 / pan_6_a
     end

     pan7 = @stats_weeks_3.select {|item| item.politic_learning  == "◯" }.length
     pan7_a = @stats_weeks_3.select {|item| item.politic_learning  == "◯" || item.politic_learning == "X" }.length
     if pan7_a == 0
     @pan_3_pl_t = 100
      else
     @pan_3_pl_t = pan7 * 100 / pan7_a
     end

     pan8 = @stats_weeks_3.select {|item| item.reviewing  == "◯" }.length
     pan8_a = @stats_weeks_3.select {|item| item.reviewing  == "◯" || item.reviewing == "X" }.length
     if pan8_a == 0
     @pan_3_re_t = 100
      else
     @pan_3_re_t = pan8 * 100 / pan8_a
     end

     pan9 = @stats_weeks_3.select {|item| item.campus_cleaning  == "◯" }.length
     pan9_a = @stats_weeks_3.select {|item| item.campus_cleaning  == "◯" || item.campus_cleaning == "X" }.length
     if pan9_a == 0
     @pan_3_cc_t = 100
      else
     @pan_3_cc_t = pan9 * 100 / pan9_a
     end

     pan10 = @stats_weeks_3.select {|item| item.room_cleaning  == "◯" }.length
     pan10_a = @stats_weeks_3.select {|item| item.room_cleaning  == "◯" || item.room_cleaning == "X" }.length
     if pan10_a == 0
     @pan_3_rc_t = 100
      else
     @pan_3_rc_t = pan10 * 100 / pan10_a
     end
     end

     unless @stats_weeks_4.empty?
     stats_count_t = @stats_weeks_4.count.to_i
     pan_4_k = @stats_weeks_4.select {|item| item.used_korean  == "ㄱ"}.length
     pan_4_n = @stats_weeks_4.select {|item| item.used_korean  == "ㄴ"}.length
     pan_4_t = @stats_weeks_4.select {|item| item.used_korean  == "ㄷ"}.length
     pan_4_r = @stats_weeks_4.select {|item| item.used_korean  == "ㄹ"}.length
     if stats_count_t == 0
     @pan_4_uk_t_k = 0
     @pan_4_uk_t_n = 0
     @pan_4_uk_t_t = 0
     @pan_4_uk_t_r = 0
     else
     @pan_4_uk_t_k = pan_4_k * 100 / stats_count_t
     @pan_4_uk_t_n = pan_4_n * 100 / stats_count_t
     @pan_4_uk_t_t = pan_4_t * 100 / stats_count_t
     @pan_4_uk_t_r = pan_4_r * 100 / stats_count_t
     end

     pan_3 = @stats_weeks_4.select {|item| item.roll_calling  == "◯" }.length
     pan_3_a = @stats_weeks_4.select {|item| item.roll_calling  == "◯" || item.roll_calling == "X" }.length
     if pan_3_a == 0
     @pan_4_mr_t = 100
      else
     @pan_4_mr_t = pan_3 * 100 / pan_3_a
     end

     pan_4 = @stats_weeks_4.select {|item| item.night_roll_calling  == "◯" }.length
     pan_4_a = @stats_weeks_4.select {|item| item.night_roll_calling  == "◯" || item.night_roll_calling == "X" }.length
     if pan_4_a == 0
     @pan_4_nr_t = 100
      else
     @pan_4_nr_t = pan_4 * 100 / pan_4_a
     end

     pan5 = @stats_weeks_4.select {|item| item.morning_meeting  == "◯" }.length
     pan_5_a = @stats_weeks_4.select {|item| item.morning_meeting  == "◯" || item.morning_meeting == "X" }.length
     if pan_5_a == 0
     @pan_4_mm_t = 100
      else
     @pan_4_mm_t = pan5 * 100 / pan_5_a
     end

     pam_6 = @stats_weeks_4.select {|item| item.attendance  == "◯" }.length
     pan_6_a = @stats_weeks_4.select {|item| item.attendance  == "◯" || item.attendance == "X" }.length
     if pan_6_a == 0
     @pan_4_at_t = 100
      else
     @pan_4_at_t = pam_6 * 100 / pan_6_a
     end

     pan7 = @stats_weeks_4.select {|item| item.politic_learning  == "◯" }.length
     pan7_a = @stats_weeks_4.select {|item| item.politic_learning  == "◯" || item.politic_learning == "X" }.length
     if pan7_a == 0
     @pan_4_pl_t = 100
      else
     @pan_4_pl_t = pan7 * 100 / pan7_a
     end

     pan8 = @stats_weeks_4.select {|item| item.reviewing  == "◯" }.length
     pan8_a = @stats_weeks_4.select {|item| item.reviewing  == "◯" || item.reviewing == "X" }.length
     if pan8_a == 0
     @pan_4_re_t = 100
      else
     @pan_4_re_t = pan8 * 100 / pan8_a
     end

     pan9 = @stats_weeks_4.select {|item| item.campus_cleaning  == "◯" }.length
     pan9_a = @stats_weeks_4.select {|item| item.campus_cleaning  == "◯" || item.campus_cleaning == "X" }.length
     if pan9_a == 0
     @pan_4_cc_t = 100
      else
     @pan_4_cc_t = pan9 * 100 / pan9_a
     end

     pan10 = @stats_weeks_4.select {|item| item.room_cleaning  == "◯" }.length
     pan10_a = @stats_weeks_4.select {|item| item.room_cleaning  == "◯" || item.room_cleaning == "X" }.length
     if pan10_a == 0
     @pan_4_rc_t = 100
      else
     @pan_4_rc_t = pan10 * 100 / pan10_a
     end
     end

  end

  def destroy
   stat = Stat.find(params[:id])
   stat.destroy
   redirect_to :controller => "users", :action => "show", :id => current_user.id
  end

private
  def create_params
    params.permit(:date,:used_korean,:korean_learning,:politic_learning,:roll_calling,:morning_meeting,:attendance,:reviewing,:study_time,:korean_books,:other_books,:room_cleaning,:campus_cleaning,:night_roll_calling)
  end

end
