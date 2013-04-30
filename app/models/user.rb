class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  def self.by_karma(page)
    users = User.find(:all, :order => "karma_sum DESC", :limit => 50, :offset => (page.to_i * 50))
    # order('karma_sum DESC')
    # joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
  end

  def self.page(per_page = 50, page_number = 1)
    limit(per_page).offset(per_page * (page_number - 1))
  end

  def total_karma
    self.karma_sum
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def calculate_karma_sum
    self.update_attribute(:karma_sum, self.karma_points.sum(:value))
  end
end
