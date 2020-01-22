module Clockwork
  configure do |config|
    config[:sleep_timeout] = 2
    config[:tz] = 'Asia/Kolkata'
    config[:max_threads] = 5
    config[:thread] = true
  end
end

Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx, [], %w(xlsx)
Mime::Type.register "application/vnd.ms-office", :xls, [], %w(xls)