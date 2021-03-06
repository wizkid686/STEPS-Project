class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      @courses = current_user.courses
      @students = current_user.students
    elsif student_signed_in?
      @courses = current_student.courses
      @available_courses = Course.all
    end
  end

  def help
  end
  
  def about
  end

  def contact
  end

  def news 
  end

  def login
  end

  private

end
