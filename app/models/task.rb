class Task < ApplicationRecord
    validates :title, presence: true

    enum :status, "未対応": 1, "処理中": 2, "処理済み": 3, "完了": 4

    belongs_to :category
end
