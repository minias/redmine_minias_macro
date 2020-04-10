require 'redmine'

#Redmine plugin 등록 
Redmine::Plugin.register :redmine_datetime_macro do
  name '광산 창민이 매크로'
  url 'https://github.com/minias/redmine_minias_macro'
  author '이창민 a.k.a minias'
  description '업무보고시 이전주 금요일{{pw}},이주 금요일{{cw}}, 다음주 금요일 매크로{{nw}}'
  author_url 'mailto:ginermail@gmail.com'
  version '0.1'
end

# 이전주 금요일 계산 함수
def prior_weekday(date, weekday)
  weekday_index = Date::DAYNAMES.reverse.index(weekday)
  days_before = (date.wday + weekday_index) % 7 + 1
  (date.to_date - days_before).to_s + "\n"
end  

#레드마인 위키포매팅 매크로 등록
Redmine::WikiFormatting::Macros.register do
  desc "매크로 사용법-(전주,이주,다음주) : \n\n <pre>{{pw}}\n{{cw}}\n{{pw}}</pre>"
  current_time = Time.now
  # YYYY-MM-DD
  macro :day do |obj, args, text|
    return current_time.year.to_s + '-' + current_time.month.to_s + '-' + current_time.day.to_s + "\n"
  end
  # MM-DD
  macro :dd do |obj, args, text|
    return current_time.month.to_s + '-' + current_time.day.to_s + "\n"
  end
  
  #prev_week 
  macro :pw do |obj, args, text|
    return prior_weekday(Date.today-7, 'Friday')
  end
  #current_week
  macro :cw do |obj, args, text|
    return prior_weekday(Date.today, 'Friday')
  end 
  #next_week
  macro :nw do |obj, args, text|
    return prior_weekday(Date.today+7, 'Friday')
  end
end
