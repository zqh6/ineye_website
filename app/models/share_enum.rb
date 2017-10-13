class ShareEnum < ApplicationRecord

  enum status:   {
    active: '生效',
    inactive: '不生效'
  }

  enum new_classify: {
    common: '普通新闻',
    medicion: '医药新闻',
    activity: '活动新闻'
  }

  enum role: {
    sys_admin: '系统管理员',
    user_admin: '用户管理员',
    common_user: '普通用户'
  }

  def self.form_options(enum_type)
    h = {}
    ShareEnum.try(enum_type.to_sym).each do |key, value|
      h[value.to_sym] = key.to_s
    end
    h
  end
  
end