class User < ActiveRecord::Base
  ################################################################################################################
  #
  # Validations
  #
  ################################################################################################################
  validates_presence_of :login, :email

  ################################################################################################################
  #
  # Associations
  #
  ################################################################################################################
  has_and_belongs_to_many :teams
  has_many :organization_memberships, :dependent => :destroy 
  
  ################################################################################################################
  #
  # Mixins
  #
  ################################################################################################################
  acts_as_authentic

  ################################################################################################################
  #
  # Attributes Accessible
  #
  ################################################################################################################
  attr_accessible :name, :color, :login, :email, :password, :password_confirmation

  ################################################################################################################
  #
  # Constants
  #
  ################################################################################################################
end
