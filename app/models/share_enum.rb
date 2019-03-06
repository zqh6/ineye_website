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
    activity: '活动新闻',
    notice: '通知公告',
    ybjc:'眼保健操'
  }

  enum role: {
    sys_admin: '系统管理员',
    user_admin: '医生管理员',
    common_user: '医生',
    outer_user: '普通用户'
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
    #optometry: '视光门诊',
    #refraction: '屈光门诊',
    vip1: 'VIP门诊',
    vip2: 'VIP传承门诊'#,
    #expert: '专家门诊'
  }

  enum official_accounts: {
    no: '不是',
    is: '是'
  }

  enum con_education_article_classifies: {
    special_lecture: '专题讲座',
    typical_case: '典型病例',
    difficult_case: '疑难病例',
    surgical_video: '手术视频'
  }

  enum article_types: {
    video: '视频',
    text: '文字',
    pdf: 'PDF'
  }

  enum doctor_levels: {
    famous_expert: '著名专家',
    chief_physician: '主任医师',
    deputy_chief_physician: '副主任医师',
    attending_doctor: '主治医师',
    in_hospital_doctor: '住院医师'
  }

  enum activity_types: {
    netease_new: '网易新闻（421）',
    netease_new_520: '网易新闻（520）',
    zyh_activity: '周跃华高考活动（611）',
    :'银海眼科祝您金榜题名' => '金榜题名(620)',
    laik: '屈光手术优惠活动',
    :'青少年近视防控行动' => '青少年近视防控行动',
    :'2018夏季特惠活动' => '2018夏季特惠活动',
    :'青少年近视防控新进展' => '青少年近视防控新进展',
    :'2018开学献礼' => '2018开学献礼',
    bnz:'白内障',
    bnzbt:'白内障补贴',
    zjhd:'摘镜活动',
    nzhk:'年终回馈',
    hdbm:'眼健康活动报名',
    jsfkjz:'青少年近视防控讲座'


  }

  def self.form_options(enum_type)
    h = {}
    ShareEnum.try(enum_type.to_sym).each do |key, value|
      h[value.to_sym] = key.to_s
    end
    h
  end

  def self.form_options_value(enum_type)
     h = {}
    ShareEnum.try(enum_type.to_sym).each do |key, value|
      h[value.to_sym] = value.to_s
    end
    h
  end
end
