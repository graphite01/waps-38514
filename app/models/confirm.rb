class Confirm < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :work_status
  belongs_to :user
  belongs_to :hope, optional: true

  with_options numericality: { other_than: 1, message: 'を入力してください' } do
    validates :work_status_id
  end

  validate :start_end_check
  validate :start_check

  def start_end_check
    errors.add(:end_time, 'は出勤時間より遅い時間を選択してください') if work_status_id == 2 && (start_time >= end_time)
  end

  def start_check
    errors.add(:start_time, 'は現在の日時より遅い時間を選択してください') if start_time < Time.now
  end
end
