class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  scope :by_age, lambda { |age| self.joins(:profile).where(profiles: {:age => age} )}
  scope :by_location, lambda { |location| self.joins(:profile).where(Profile.arel_table[:location].lower.matches("%#{location.downcase}%")) }
  #scope :by_instrument, lambda { |instrument| self.joins(:profile).joins(:instrument_profile, :instrument).where(Instrument.arel_table[:name].lower.matches("%#{instrument.downcase}%")) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :profile, :dependent => :destroy
  before_create :build_default_profile
  
  private

    def build_default_profile
      # build default profile instance. Will use default params.
      # The foreign key to the owning User model is set automatically
      build_profile
      true # Always return true in callbacks as the normal 'continue' state
           # Assumes that the default_profile can **always** be created.
           # or
           # Check the validation of the profile. If it is not valid, then
           # return false from the callback. Best to use a before_validation 
           # if doing this. View code should check the errors of the child.
           # Or add the child's errors to the User model's error array of the :base
           # error item
    end
         
end

# Location, instruments + proficiency (profile_instrument many-to-many pivot table), artists, genres, desired instruments
