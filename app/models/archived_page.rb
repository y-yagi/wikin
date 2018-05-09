class ArchivedPage < ApplicationRecord
  def restore!
    attr = self.attributes

    attr.delete("id")
    attr["created_at"] = attr.delete("original_created_at")
    attr["updated_at"] = attr.delete("original_updated_at")

    ApplicationRecord.transaction do
      Page.create!(attr)
      destroy!
    end
  end
end
