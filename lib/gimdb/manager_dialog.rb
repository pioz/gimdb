require "#{$APP_PATH}/lib/gimdb/ui/ui_manager_dialog"

class ManagerDialog < Qt::Dialog
  attr_reader :ui

  slots 'on_combo_currentIndexChanged(const QString&)',
        'on_combo_editTextChanged(const QString&)',
        'on_button_control_clicked()'

  def initialize(users, parent)
    super(parent)
    @users = users
    @status = :add
    @ui = Ui_Manager_dialog.new
    @ui.setupUi(self)
    build_combo
    #self.adjustSize
    self.minimumSize = self.size
    self.maximumSize = self.size
  end
  
  private
  
  def build_combo
    @ui.combo.clear
    @ui.combo.addItem('')
    @users.each do |u|
      @ui.combo.addItem(u.name)
    end
  end
  
  def on_combo_currentIndexChanged(text)
    if @ui.combo.currentIndex == 0
      status = :add
    elsif @users.map(&:name).include?(@ui.combo.currentText)
      status = :delete
    else
      status = :edit
    end
    if @status != status
      @status = status      
      @ui.button_control.text = tr(@status.to_s.capitalize)
    end
  end
  alias :on_combo_editTextChanged :on_combo_currentIndexChanged

  def on_button_control_clicked
    case @status
    when :add
      u = User.new(:name => @ui.combo.currentText)
      u.save!
      @users << u
    when :edit
      u = @users[@ui.combo.currentIndex-1]
      u.name = @ui.combo.currentText
      u.save!
    when :delete
      u = @users[@ui.combo.currentIndex-1]
      @users.delete_at(@ui.combo.currentIndex-1)
      u.destroy
    end
    build_combo
    parent.build_users_selection(@users)
  end

end