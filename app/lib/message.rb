class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.schedule_created
    'Schedule created successfuly.'
  end

  def self.schedule_deleted
    'Schedule deleted successfully.'
  end

  def self.task_created
    'Task added to your schedule successfully.'
  end

  def self.task_deleted
    'Task removed from your schedule successfully.'
  end
  
  def self.task_completed
    'Congratulations! You have successfully completed this task.'
  end
end