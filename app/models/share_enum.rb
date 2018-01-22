class ShareEnum < ApplicationRecord

  enum status:   {
    active: '生效',
    inactive: '不生效'
  }

  enum state: {
    C: '生效',
    D: '不生效'
  }

  enum new_classify: {
    common: '普通新闻',
    science: '科普新闻',
    medicion: '医药新闻',
    activity: '活动新闻'
  }

  enum role: {
    sys_admin: '系统管理员',
    user_admin: '用户管理员',
    common_user: '普通用户'
  }

  enum aim_at_platform: {
    pc: 'PC端',
    mobile: '手机端',
    pc_and_mobile: 'PC端、手机端'
  }

  enum am_pms: {
    am: '上午',
    pm: '下午',
    am_and_pm: '全天'
  }

  enum weeks: {
    monday: '星期一',
    tuesday: '星期二',
    wednesday: '星期三',
    tursday: '星期四',
    friday: '星期五',
    saturday: '星期六',
    sunday: '星期日'
  }

  enum outpatient_services: {
    common_service: '普通门诊',
    optometry: '视光门诊',
    refraction: '屈光门诊',
    vip1: 'VIP门诊',
    vip2: 'VIP传承门诊',
    expert: '专家门诊'
  }

  def self.form_options(enum_type)
    h = {}
    ShareEnum.try(enum_type.to_sym).each do |key, value|
      h[value.to_sym] = key.to_s
    end
    h
  end
  
end