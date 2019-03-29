Sidekiq.configure_server do
  schedule_file = 'config/job_schedule.yml'

  if Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end
