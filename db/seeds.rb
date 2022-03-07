5.times { |t| User.create!(name: "user#{t+1}", email: "user#{t+1}@example.com", password: 'password') }
5.times { |t| User.create!(name: "admin#{t+1}", email: "admin#{t+1}@example.com", password: 'password', admin: true) }

50.times { |t| Task.create!(title: "task_title_#{t}", content: "task_content_#{t}", deadline_on: Date.today + t, status: Task.statuses.keys.sample, priority: Task.priorities.keys.sample, user_id: User.all.sample.id) }
