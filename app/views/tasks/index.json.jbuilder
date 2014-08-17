json.array!(@tasks) do |task|
  json.extract! task, :id, :id, :name, :status, :project_id
  json.url task_url(task, format: :json)
end
