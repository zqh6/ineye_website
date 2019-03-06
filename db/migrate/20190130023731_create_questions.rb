class CreateQuestions < ActiveRecord::Migration[5.0]
  def change

    create_table :questions do |t|

      t.string :questions_1
      t.string :answer_1
      t.string :questions_2
      t.string :answer_2
      t.string :questions_3
      t.string :answer_3
      t.string :questions_4
      t.string :answer_4
      t.string :questions_5
      t.string :answer_5
      t.string :questions_6
      t.string :answer_6
      t.string :questions_7
      t.string :answer_7
      t.string :questions_8
      t.string :answer_8
      t.string :questions_9
      t.string :answer_9
      t.string :questions_10
      t.string :answer_10
      t.string :suggestions

    end
  end
end
