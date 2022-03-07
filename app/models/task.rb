class Task < ApplicationRecord
  enum priority: { low: 0, mid: 1, high: 2 }
  enum status: { not_yet: 0, in_progress: 1, done: 2 }

  has_and_belongs_to_many :labels
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  scope :newer, -> { order(created_at: :desc) }

  def self.searched_by(subjects, user)
    result = Task.where(user: user)

    return result unless subjects

    result = result.where(status: subjects[:status]) if subjects[:status].present?
    result = result.where('tasks.title LIKE ?', "%#{subjects[:title]}%") if subjects[:title].present?
    result = result.joins(:labels).where('labels.id': subjects[:label_id]) if subjects[:label_id].present?
    result
  end

  def self.desc_sort_by(column, direction)
    return newer unless column
    return newer unless %w[due_on priority].include?(column)
    return newer unless %w[ASC DESC].include?(direction)

    order("#{column} #{direction}")
  end
end
