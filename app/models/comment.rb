class Comment < ApplicationRecord

  scope :post_id_is, ->(post_id) { where "#{table_name}.post_id = :post_id ", post_id: post_id }
  scope :post_link_is, ->(post_link) { where "#{table_name}.post_link = :post_link ", post_link: post_link }
  scope :parent_id_is, ->(parent_id) { where "#{table_name}.parent_id = :parent_id ", parent_id: parent_id }

  scope :state_is, ->(state) { where "#{table_name}.state = :state ", state: state }
  scope :state_in, ->(states) { where "#{table_name}.state in (:states) ", states: states }

  def state_desc
    state_desc = ''
    case self.state
      when 'C'
        state_desc = '等待审核'
      when 'D'
        state_desc = '审核不通过'
      when 'A'
        state_desc = '审核通过'
    end
    state_desc
  end

  def parent_id_desc
    self.parent_id==nil ? '顶级评论' : self.parent_id
  end

  def creator_id_desc
    self.creator_id==nil ? '游客' : User.included_by(self.creator_id).first.try(:name)
  end

  def auditor_id_desc
    self.auditor_id.blank? ? '' : User.included_by(self.auditor_id).first.try(:name)
  end

end
