=begin
** Form generated from reading ui file 'manager_dialog.ui'
**
** Created: lun ott 10 20:28:24 2011
**      by: Qt User Interface Compiler version 4.7.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_Manager_dialog
    attr_reader :verticalLayout_2
    attr_reader :buttons_container
    attr_reader :combo
    attr_reader :button_control

    def setupUi(manager_dialog)
    if manager_dialog.objectName.nil?
        manager_dialog.objectName = "manager_dialog"
    end
    manager_dialog.windowModality = Qt::WindowModal
    manager_dialog.resize(293, 33)
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Minimum, Qt::SizePolicy::Minimum)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = manager_dialog.sizePolicy.hasHeightForWidth
    manager_dialog.sizePolicy = @sizePolicy
    icon = Qt::Icon.new
    icon.addPixmap(Qt::Pixmap.new(":/icons/gimdb.png"), Qt::Icon::Normal, Qt::Icon::Off)
    manager_dialog.windowIcon = icon
    manager_dialog.modal = true
    @verticalLayout_2 = Qt::VBoxLayout.new(manager_dialog)
    @verticalLayout_2.spacing = 2
    @verticalLayout_2.margin = 2
    @verticalLayout_2.objectName = "verticalLayout_2"
    @buttons_container = Qt::HBoxLayout.new()
    @buttons_container.spacing = 2
    @buttons_container.objectName = "buttons_container"
    @combo = Qt::ComboBox.new(manager_dialog)
    @combo.objectName = "combo"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Maximum, Qt::SizePolicy::Maximum)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(0)
    @sizePolicy1.heightForWidth = @combo.sizePolicy.hasHeightForWidth
    @combo.sizePolicy = @sizePolicy1
    @combo.minimumSize = Qt::Size.new(200, 0)
    @combo.editable = true

    @buttons_container.addWidget(@combo)

    @button_control = Qt::PushButton.new(manager_dialog)
    @button_control.objectName = "button_control"
    @sizePolicy2 = Qt::SizePolicy.new(Qt::SizePolicy::Minimum, Qt::SizePolicy::Maximum)
    @sizePolicy2.setHorizontalStretch(0)
    @sizePolicy2.setVerticalStretch(0)
    @sizePolicy2.heightForWidth = @button_control.sizePolicy.hasHeightForWidth
    @button_control.sizePolicy = @sizePolicy2

    @buttons_container.addWidget(@button_control)


    @verticalLayout_2.addLayout(@buttons_container)


    retranslateUi(manager_dialog)

    Qt::MetaObject.connectSlotsByName(manager_dialog)
    end # setupUi

    def setup_ui(manager_dialog)
        setupUi(manager_dialog)
    end

    def retranslateUi(manager_dialog)
    manager_dialog.windowTitle = Qt::Application.translate("manager_dialog", "Manage users", nil, Qt::Application::UnicodeUTF8)
    @button_control.text = Qt::Application.translate("manager_dialog", "Add", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(manager_dialog)
        retranslateUi(manager_dialog)
    end

end

module Ui
    class Manager_dialog < Ui_Manager_dialog
    end
end  # module Ui

