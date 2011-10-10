=begin
** Form generated from reading ui file 'statusbar.ui'
**
** Created: lun ott 10 02:17:38 2011
**      by: Qt User Interface Compiler version 4.7.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_Statusbar
    attr_reader :horizontalLayout_2
    attr_reader :progressbar
    attr_reader :status_text
    attr_reader :horizontalSpacer
    attr_reader :image_offline
    attr_reader :image_spinner

    def setupUi(statusbar)
    if statusbar.objectName.nil?
        statusbar.objectName = "statusbar"
    end
    statusbar.resize(483, 16)
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Expanding, Qt::SizePolicy::Fixed)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = statusbar.sizePolicy.hasHeightForWidth
    statusbar.sizePolicy = @sizePolicy
    statusbar.minimumSize = Qt::Size.new(0, 0)
    @horizontalLayout_2 = Qt::HBoxLayout.new(statusbar)
    @horizontalLayout_2.spacing = 2
    @horizontalLayout_2.margin = 0
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @progressbar = Qt::ProgressBar.new(statusbar)
    @progressbar.objectName = "progressbar"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Maximum, Qt::SizePolicy::Maximum)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(0)
    @sizePolicy1.heightForWidth = @progressbar.sizePolicy.hasHeightForWidth
    @progressbar.sizePolicy = @sizePolicy1
    @progressbar.minimumSize = Qt::Size.new(200, 16)
    @progressbar.maximumSize = Qt::Size.new(200, 16)
    @progressbar.value = 0

    @horizontalLayout_2.addWidget(@progressbar)

    @status_text = Qt::Label.new(statusbar)
    @status_text.objectName = "status_text"
    @sizePolicy1.heightForWidth = @status_text.sizePolicy.hasHeightForWidth
    @status_text.sizePolicy = @sizePolicy1
    @status_text.minimumSize = Qt::Size.new(0, 16)
    @status_text.maximumSize = Qt::Size.new(16777215, 16)

    @horizontalLayout_2.addWidget(@status_text)

    @horizontalSpacer = Qt::SpacerItem.new(4000, 16, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_2.addItem(@horizontalSpacer)

    @image_offline = Qt::Label.new(statusbar)
    @image_offline.objectName = "image_offline"
    @image_offline.enabled = true
    @sizePolicy1.heightForWidth = @image_offline.sizePolicy.hasHeightForWidth
    @image_offline.sizePolicy = @sizePolicy1
    @image_offline.minimumSize = Qt::Size.new(16, 16)
    @image_offline.maximumSize = Qt::Size.new(16, 16)
    @image_offline.pixmap = Qt::Pixmap.new(":/icons/offline.png")
    @image_offline.scaledContents = true

    @horizontalLayout_2.addWidget(@image_offline)

    @image_spinner = Qt::Label.new(statusbar)
    @image_spinner.objectName = "image_spinner"
    @sizePolicy1.heightForWidth = @image_spinner.sizePolicy.hasHeightForWidth
    @image_spinner.sizePolicy = @sizePolicy1
    @image_spinner.minimumSize = Qt::Size.new(16, 16)
    @image_spinner.maximumSize = Qt::Size.new(16, 16)

    @horizontalLayout_2.addWidget(@image_spinner)


    retranslateUi(statusbar)

    Qt::MetaObject.connectSlotsByName(statusbar)
    end # setupUi

    def setup_ui(statusbar)
        setupUi(statusbar)
    end

    def retranslateUi(statusbar)
    statusbar.windowTitle = ''
    @status_text.text = ''
    @image_offline.text = ''
    @image_spinner.text = ''
    end # retranslateUi

    def retranslate_ui(statusbar)
        retranslateUi(statusbar)
    end

end

module Ui
    class Statusbar < Ui_Statusbar
    end
end  # module Ui

