class UserAction < Qt::Action
  
  slots 'toggle(bool)'
  
  def initialize(user, parent)
    super(user.name, parent)
    @user = user
    self.checkable = true
    self.checked = @user.selected
    self.objectName = 'user_action'
    connect(self, SIGNAL('toggled(bool)'), self, SLOT('toggle(bool)'))
  end
  
  private
  
  def toggle(value)
    @user.selected = value
    @user.save!
    if value
      parent.movieboxes.each do |moviebox|
        moviebox.add_user_control(@user)
      end
    end
  end
  
end