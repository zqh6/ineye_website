class AddIndexToSchedulingAbout < ActiveRecord::Migration[5.0]
  def change

    add_index :offices, :name
    add_index :offices, :state
    add_index :offices, :defunct

    add_index :office_times, :office_id
    add_index :office_times, :am_pm_code
    add_index :office_times, :state
    add_index :office_times, :created_at
    add_index :office_times, :opened_at
    add_index :office_times, :closed_at
    add_index :office_times, :defunct

    add_index :schedulings, :office_time_id
    add_index :schedulings, :user_id
    add_index :schedulings, :week_code
    add_index :schedulings, :outpatient_service_type
    add_index :schedulings, :state
    add_index :schedulings, :defunct

    add_index :ask_for_leaves, :user_id
    add_index :ask_for_leaves, :am_pm_code
    add_index :ask_for_leaves, :day
    add_index :ask_for_leaves, :state
    add_index :ask_for_leaves, :defunct
    add_index :ask_for_leaves, :office_id

  end
end
