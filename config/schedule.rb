every :hour do
  runner "PopulateOffendersJob.perform_now"
end
