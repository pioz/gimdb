=begin
** Form generated from reading ui file 'moviebox.ui'
**
** Created: mar ott 11 17:41:49 2011
**      by: Qt User Interface Compiler version 4.7.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_Moviebox
    attr_reader :verticalLayout
    attr_reader :horizontalLayout
    attr_reader :poster
    attr_reader :verticalLayout_2
    attr_reader :horizontalLayout_2
    attr_reader :title
    attr_reader :year
    attr_reader :horizontalSpacer
    attr_reader :rating
    attr_reader :outline
    attr_reader :credit
    attr_reader :horizontalLayout_3
    attr_reader :label_5
    attr_reader :genres
    attr_reader :horizontalSpacer_2
    attr_reader :runtime
    attr_reader :horizontalLayout_4
    attr_reader :users_box
    attr_reader :horizontalSpacer_3
    attr_reader :verticalSpacer
    attr_reader :line

    def setupUi(moviebox)
    if moviebox.objectName.nil?
        moviebox.objectName = "moviebox"
    end
    moviebox.resize(435, 250)
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Preferred)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = moviebox.sizePolicy.hasHeightForWidth
    moviebox.sizePolicy = @sizePolicy
    @verticalLayout = Qt::VBoxLayout.new(moviebox)
    @verticalLayout.margin = 2
    @verticalLayout.objectName = "verticalLayout"
    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.objectName = "horizontalLayout"
    @poster = Qt::Label.new(moviebox)
    @poster.objectName = "poster"
    @poster.minimumSize = Qt::Size.new(160, 235)
    @poster.maximumSize = Qt::Size.new(160, 235)
    @poster.styleSheet = "QLabel {\n" \
"	border: 2px outset gray;\n" \
"	border-radius: 20px;\n" \
"	background-image: url(:/icons/no_poster.png);\n" \
"}"
    @poster.scaledContents = true

    @horizontalLayout.addWidget(@poster)

    @verticalLayout_2 = Qt::VBoxLayout.new()
    @verticalLayout_2.objectName = "verticalLayout_2"
    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @title = Qt::Label.new(moviebox)
    @title.objectName = "title"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Maximum, Qt::SizePolicy::Maximum)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(0)
    @sizePolicy1.heightForWidth = @title.sizePolicy.hasHeightForWidth
    @title.sizePolicy = @sizePolicy1
    @title.cursor = Qt::Cursor.new(Qt::IBeamCursor)
    @title.styleSheet = "QLabel {\n" \
"	font-size: 14pt;\n" \
"	font-weight: bold;\n" \
"\n" \
"}"
    @title.textFormat = Qt::AutoText
    @title.scaledContents = true
    @title.openExternalLinks = true
    @title.textInteractionFlags = Qt::LinksAccessibleByMouse|Qt::TextSelectableByMouse

    @horizontalLayout_2.addWidget(@title)

    @year = Qt::Label.new(moviebox)
    @year.objectName = "year"
    @sizePolicy1.heightForWidth = @year.sizePolicy.hasHeightForWidth
    @year.sizePolicy = @sizePolicy1
    @year.textInteractionFlags = Qt::LinksAccessibleByMouse|Qt::TextSelectableByMouse

    @horizontalLayout_2.addWidget(@year)

    @horizontalSpacer = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_2.addItem(@horizontalSpacer)

    @rating = Qt::Label.new(moviebox)
    @rating.objectName = "rating"
    @sizePolicy1.heightForWidth = @rating.sizePolicy.hasHeightForWidth
    @rating.sizePolicy = @sizePolicy1
    @rating.textInteractionFlags = Qt::LinksAccessibleByMouse|Qt::TextSelectableByMouse

    @horizontalLayout_2.addWidget(@rating)


    @verticalLayout_2.addLayout(@horizontalLayout_2)

    @outline = Qt::Label.new(moviebox)
    @outline.objectName = "outline"
    @sizePolicy2 = Qt::SizePolicy.new(Qt::SizePolicy::Expanding, Qt::SizePolicy::Maximum)
    @sizePolicy2.setHorizontalStretch(0)
    @sizePolicy2.setVerticalStretch(0)
    @sizePolicy2.heightForWidth = @outline.sizePolicy.hasHeightForWidth
    @outline.sizePolicy = @sizePolicy2
    @outline.wordWrap = true
    @outline.textInteractionFlags = Qt::LinksAccessibleByMouse|Qt::TextSelectableByMouse

    @verticalLayout_2.addWidget(@outline)

    @credit = Qt::Label.new(moviebox)
    @credit.objectName = "credit"
    @sizePolicy1.heightForWidth = @credit.sizePolicy.hasHeightForWidth
    @credit.sizePolicy = @sizePolicy1
    @credit.textInteractionFlags = Qt::LinksAccessibleByMouse|Qt::TextSelectableByMouse

    @verticalLayout_2.addWidget(@credit)

    @horizontalLayout_3 = Qt::HBoxLayout.new()
    @horizontalLayout_3.objectName = "horizontalLayout_3"
    @label_5 = Qt::Label.new(moviebox)
    @label_5.objectName = "label_5"
    @sizePolicy1.heightForWidth = @label_5.sizePolicy.hasHeightForWidth
    @label_5.sizePolicy = @sizePolicy1
    @label_5.styleSheet = "QLabel {\n" \
"	font-size: 10pt;\n" \
"}\n" \
""

    @horizontalLayout_3.addWidget(@label_5)

    @genres = Qt::Label.new(moviebox)
    @genres.objectName = "genres"
    @sizePolicy1.heightForWidth = @genres.sizePolicy.hasHeightForWidth
    @genres.sizePolicy = @sizePolicy1
    @genres.textInteractionFlags = Qt::LinksAccessibleByMouse|Qt::TextSelectableByMouse

    @horizontalLayout_3.addWidget(@genres)

    @horizontalSpacer_2 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_3.addItem(@horizontalSpacer_2)

    @runtime = Qt::Label.new(moviebox)
    @runtime.objectName = "runtime"
    @sizePolicy1.heightForWidth = @runtime.sizePolicy.hasHeightForWidth
    @runtime.sizePolicy = @sizePolicy1
    @runtime.styleSheet = "QLabel {\n" \
"	font-family: courier;\n" \
"}"
    @runtime.textInteractionFlags = Qt::LinksAccessibleByMouse|Qt::TextSelectableByMouse

    @horizontalLayout_3.addWidget(@runtime)


    @verticalLayout_2.addLayout(@horizontalLayout_3)

    @horizontalLayout_4 = Qt::HBoxLayout.new()
    @horizontalLayout_4.objectName = "horizontalLayout_4"
    @users_box = Qt::GridLayout.new()
    @users_box.objectName = "users_box"

    @horizontalLayout_4.addLayout(@users_box)

    @horizontalSpacer_3 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_4.addItem(@horizontalSpacer_3)


    @verticalLayout_2.addLayout(@horizontalLayout_4)

    @verticalSpacer = Qt::SpacerItem.new(20, 40, Qt::SizePolicy::Minimum, Qt::SizePolicy::Preferred)

    @verticalLayout_2.addItem(@verticalSpacer)


    @horizontalLayout.addLayout(@verticalLayout_2)


    @verticalLayout.addLayout(@horizontalLayout)

    @line = Qt::Frame.new(moviebox)
    @line.objectName = "line"
    @line.setFrameShape(Qt::Frame::HLine)
    @line.setFrameShadow(Qt::Frame::Sunken)

    @verticalLayout.addWidget(@line)


    retranslateUi(moviebox)

    Qt::MetaObject.connectSlotsByName(moviebox)
    end # setupUi

    def setup_ui(moviebox)
        setupUi(moviebox)
    end

    def retranslateUi(moviebox)
    moviebox.windowTitle = Qt::Application.translate("moviebox", "Form", nil, Qt::Application::UnicodeUTF8)
    @poster.text = ''
    @title.text = Qt::Application.translate("moviebox", "title", nil, Qt::Application::UnicodeUTF8)
    @year.text = Qt::Application.translate("moviebox", "(year)", nil, Qt::Application::UnicodeUTF8)
    @rating.text = Qt::Application.translate("moviebox", "vote/10", nil, Qt::Application::UnicodeUTF8)
    @outline.text = Qt::Application.translate("moviebox", "outline", nil, Qt::Application::UnicodeUTF8)
    @credit.text = Qt::Application.translate("moviebox", "credit", nil, Qt::Application::UnicodeUTF8)
    @label_5.text = Qt::Application.translate("moviebox", "Genres:", nil, Qt::Application::UnicodeUTF8)
    @genres.text = Qt::Application.translate("moviebox", "genres", nil, Qt::Application::UnicodeUTF8)
    @runtime.text = Qt::Application.translate("moviebox", "runtime", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(moviebox)
        retranslateUi(moviebox)
    end

end

module Ui
    class Moviebox < Ui_Moviebox
    end
end  # module Ui

