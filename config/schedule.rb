every 30.minutes do
  runner "PopulateOffendersJob.perform_now"
end
