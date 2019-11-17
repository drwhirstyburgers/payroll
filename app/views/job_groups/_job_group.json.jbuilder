json.extract! job_group, :id, :name, :wage, :created_at, :updated_at
json.url job_group_url(job_group, format: :json)
