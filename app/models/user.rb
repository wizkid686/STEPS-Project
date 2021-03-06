class User < ActiveRecord::Base
  has_many :courses, dependent: :destroy
  has_many :students, through: :courses
  has_many :passes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  scope :by_school, -> (school) { where(:school_name => school) } 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :location, length: { maximum: 50 }
  validates :user_number, presence: true,
                          numericality: { only_integer:true, allow_nil: true },
                          uniqueness: { message: "An account with that user id already exists" },
                          length: {maximum: 8 }

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def fullname 
    "#{first_name} #{last_name}"
  end

  def pass_destinations
    destinations = [['Main Office','Office'],['Student Affairs','Student Affairs'],['Guidance', 'Guidance'],['Media Center', 'Media Center'],['Restroom', 'Restroom']]
    destinations.sort!
    destinations.unshift(['School Locations:',' '])
    destinations.push(['Teachers:',' '])
    destinations += User.by_school(self.school_name).pluck(:last_name, :location).sort!
    destinations += [['Other', 'Other']]
    return destinations
  end

  def self.subject
    ["CTE", "ESE", "Language Arts", "Mathematics", 
    "Physical Education", "Reading", "Science", "Social Studies"]
  end

  def self.instruction_level
    ["Middle School (6-8)", "High School (9-12)"]
  end
  
  def self.middle_schools
    require 'csv'
    file = "#{Rails.root}/app/models/school_list.csv"
    middle_schools = []
    if File.exist?(file)
      list = CSV.foreach(file, :col_sep => ",", :headers => true) do |row|
        middle_schools << row[0]
      end
    end
    middle_schools.compact!
    return middle_schools
  end

  def self.high_schools
    require 'csv'
    file = "#{Rails.root}/app/models/school_list.csv"
    high_schools = []
    if File.exist?(file)
      list = CSV.foreach(file, :col_sep => ",", :headers => true) do |row|
        high_schools << row[2]
      end
    end
    high_schools.compact!
    return high_schools
  end
end
