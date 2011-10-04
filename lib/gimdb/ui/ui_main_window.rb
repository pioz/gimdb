=begin
** Form generated from reading ui file 'main_window.ui'
**
** Created: mar ott 4 23:56:33 2011
**      by: Qt User Interface Compiler version 4.7.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_Main_window
    attr_reader :menu_find
    attr_reader :menu_next
    attr_reader :menu_cancel
    attr_reader :menu_to_see
    attr_reader :menu_seen
    attr_reader :menu_favourites
    attr_reader :menu_offline
    attr_reader :menu_exit
    attr_reader :menu_elect_users
    attr_reader :menu_edit_users
    attr_reader :menu_hide_sidebar
    attr_reader :menu_clear
    attr_reader :menu_about
    attr_reader :centralwidget
    attr_reader :horizontalLayout
    attr_reader :sidebar
    attr_reader :line_edit_search
    attr_reader :horizontalLayout_2
    attr_reader :label
    attr_reader :spin_year_from
    attr_reader :label_2
    attr_reader :spin_year_to
    attr_reader :horizontalSpacer
    attr_reader :horizontalLayout_3
    attr_reader :label_3
    attr_reader :combo_rating_min
    attr_reader :label_4
    attr_reader :combo_rating_max
    attr_reader :groupBox
    attr_reader :gridLayout_2
    attr_reader :check_genres_all
    attr_reader :check_genres_action
    attr_reader :check_genres_adventure
    attr_reader :check_genres_animation
    attr_reader :check_genres_biography
    attr_reader :check_genres_comedy
    attr_reader :check_genres_crime
    attr_reader :check_genres_documentary
    attr_reader :check_genres_drama
    attr_reader :check_genres_family
    attr_reader :check_genres_fantasy
    attr_reader :check_genres_film_noir
    attr_reader :check_genres_game_show
    attr_reader :check_genres_history
    attr_reader :check_genres_horror
    attr_reader :check_genres_music
    attr_reader :check_genres_musical
    attr_reader :check_genres_mystery
    attr_reader :check_genres_news
    attr_reader :check_genres_romance
    attr_reader :check_genres_scifi
    attr_reader :check_genres_sport
    attr_reader :check_genres_thriller
    attr_reader :check_genres_war
    attr_reader :check_genres_western
    attr_reader :horizontalLayout_4
    attr_reader :label_7
    attr_reader :combo_sort
    attr_reader :button_sort_inv
    attr_reader :verticalSpacer
    attr_reader :check_hide_seen
    attr_reader :line
    attr_reader :horizontalLayout_5
    attr_reader :button_clear
    attr_reader :button_find
    attr_reader :button_cancel
    attr_reader :scrollarea
    attr_reader :scrollAreaWidgetContents
    attr_reader :verticalLayout_2
    attr_reader :verticalSpacer_2
    attr_reader :menubar
    attr_reader :menuFile
    attr_reader :menuView
    attr_reader :menuHelp
    attr_reader :statusbar

    def setupUi(main_window)
    if main_window.objectName.nil?
        main_window.objectName = "main_window"
    end
    main_window.resize(800, 600)
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Maximum, Qt::SizePolicy::Maximum)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = main_window.sizePolicy.hasHeightForWidth
    main_window.sizePolicy = @sizePolicy
    main_window.minimumSize = Qt::Size.new(800, 0)
    icon = Qt::Icon.new
    icon.addPixmap(Qt::Pixmap.new("../gimdb/data/icons/gimdb.png"), Qt::Icon::Normal, Qt::Icon::Off)
    main_window.windowIcon = icon
    main_window.unifiedTitleAndToolBarOnMac = false
    @menu_find = Qt::Action.new(main_window)
    @menu_find.objectName = "menu_find"
    icon1 = Qt::Icon.new
    icon1.addPixmap(Qt::Pixmap.new(":/icons/find.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_find.icon = icon1
    @menu_find.iconVisibleInMenu = true
    @menu_next = Qt::Action.new(main_window)
    @menu_next.objectName = "menu_next"
    icon2 = Qt::Icon.new
    icon2.addPixmap(Qt::Pixmap.new(":/icons/next.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_next.icon = icon2
    @menu_next.iconVisibleInMenu = true
    @menu_cancel = Qt::Action.new(main_window)
    @menu_cancel.objectName = "menu_cancel"
    icon3 = Qt::Icon.new
    icon3.addPixmap(Qt::Pixmap.new(":/icons/cancel.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_cancel.icon = icon3
    @menu_cancel.iconVisibleInMenu = true
    @menu_to_see = Qt::Action.new(main_window)
    @menu_to_see.objectName = "menu_to_see"
    icon4 = Qt::Icon.new
    icon4.addPixmap(Qt::Pixmap.new(":/icons/to_see.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_to_see.icon = icon4
    @menu_to_see.iconVisibleInMenu = true
    @menu_seen = Qt::Action.new(main_window)
    @menu_seen.objectName = "menu_seen"
    icon5 = Qt::Icon.new
    icon5.addPixmap(Qt::Pixmap.new(":/icons/seen.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_seen.icon = icon5
    @menu_seen.iconVisibleInMenu = true
    @menu_favourites = Qt::Action.new(main_window)
    @menu_favourites.objectName = "menu_favourites"
    icon6 = Qt::Icon.new
    icon6.addPixmap(Qt::Pixmap.new(":/icons/favorites.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_favourites.icon = icon6
    @menu_favourites.iconVisibleInMenu = true
    @menu_offline = Qt::Action.new(main_window)
    @menu_offline.objectName = "menu_offline"
    @menu_offline.checkable = true
    @menu_exit = Qt::Action.new(main_window)
    @menu_exit.objectName = "menu_exit"
    icon7 = Qt::Icon.new
    icon7.addPixmap(Qt::Pixmap.new(":/icons/exit.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_exit.icon = icon7
    @menu_exit.iconVisibleInMenu = true
    @menu_elect_users = Qt::Action.new(main_window)
    @menu_elect_users.objectName = "menu_elect_users"
    icon8 = Qt::Icon.new
    icon8.addPixmap(Qt::Pixmap.new(":/icons/select_users.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_elect_users.icon = icon8
    @menu_elect_users.iconVisibleInMenu = true
    @menu_edit_users = Qt::Action.new(main_window)
    @menu_edit_users.objectName = "menu_edit_users"
    icon9 = Qt::Icon.new
    icon9.addPixmap(Qt::Pixmap.new(":/icons/edit_users.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_edit_users.icon = icon9
    @menu_edit_users.iconVisibleInMenu = true
    @menu_hide_sidebar = Qt::Action.new(main_window)
    @menu_hide_sidebar.objectName = "menu_hide_sidebar"
    icon10 = Qt::Icon.new
    icon10.addPixmap(Qt::Pixmap.new(":/icons/hide_sidebar.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_hide_sidebar.icon = icon10
    @menu_hide_sidebar.iconVisibleInMenu = true
    @menu_clear = Qt::Action.new(main_window)
    @menu_clear.objectName = "menu_clear"
    icon11 = Qt::Icon.new
    icon11.addPixmap(Qt::Pixmap.new(":/icons/clear.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_clear.icon = icon11
    @menu_clear.iconVisibleInMenu = true
    @menu_about = Qt::Action.new(main_window)
    @menu_about.objectName = "menu_about"
    icon12 = Qt::Icon.new
    icon12.addPixmap(Qt::Pixmap.new(":/icons/about.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @menu_about.icon = icon12
    @menu_about.iconVisibleInMenu = true
    @centralwidget = Qt::Widget.new(main_window)
    @centralwidget.objectName = "centralwidget"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Expanding, Qt::SizePolicy::Expanding)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(0)
    @sizePolicy1.heightForWidth = @centralwidget.sizePolicy.hasHeightForWidth
    @centralwidget.sizePolicy = @sizePolicy1
    @centralwidget.autoFillBackground = false
    @horizontalLayout = Qt::HBoxLayout.new(@centralwidget)
    @horizontalLayout.margin = 2
    @horizontalLayout.objectName = "horizontalLayout"
    @sidebar = Qt::VBoxLayout.new()
    @sidebar.spacing = 2
    @sidebar.objectName = "sidebar"
    @sidebar.sizeConstraint = Qt::Layout::SetDefaultConstraint
    @line_edit_search = Qt::LineEdit.new(@centralwidget)
    @line_edit_search.objectName = "line_edit_search"
    @sizePolicy2 = Qt::SizePolicy.new(Qt::SizePolicy::Minimum, Qt::SizePolicy::Maximum)
    @sizePolicy2.setHorizontalStretch(0)
    @sizePolicy2.setVerticalStretch(0)
    @sizePolicy2.heightForWidth = @line_edit_search.sizePolicy.hasHeightForWidth
    @line_edit_search.sizePolicy = @sizePolicy2

    @sidebar.addWidget(@line_edit_search)

    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @label = Qt::Label.new(@centralwidget)
    @label.objectName = "label"
    @sizePolicy.heightForWidth = @label.sizePolicy.hasHeightForWidth
    @label.sizePolicy = @sizePolicy

    @horizontalLayout_2.addWidget(@label)

    @spin_year_from = Qt::SpinBox.new(@centralwidget)
    @spin_year_from.objectName = "spin_year_from"
    @sizePolicy.heightForWidth = @spin_year_from.sizePolicy.hasHeightForWidth
    @spin_year_from.sizePolicy = @sizePolicy
    @spin_year_from.minimum = 1970
    @spin_year_from.maximum = 2100

    @horizontalLayout_2.addWidget(@spin_year_from)

    @label_2 = Qt::Label.new(@centralwidget)
    @label_2.objectName = "label_2"
    @sizePolicy.heightForWidth = @label_2.sizePolicy.hasHeightForWidth
    @label_2.sizePolicy = @sizePolicy

    @horizontalLayout_2.addWidget(@label_2)

    @spin_year_to = Qt::SpinBox.new(@centralwidget)
    @spin_year_to.objectName = "spin_year_to"
    @sizePolicy.heightForWidth = @spin_year_to.sizePolicy.hasHeightForWidth
    @spin_year_to.sizePolicy = @sizePolicy
    @spin_year_to.minimum = 1970
    @spin_year_to.maximum = 2100
    @spin_year_to.value = 2000

    @horizontalLayout_2.addWidget(@spin_year_to)

    @horizontalSpacer = Qt::SpacerItem.new(0, 20, Qt::SizePolicy::Minimum, Qt::SizePolicy::Minimum)

    @horizontalLayout_2.addItem(@horizontalSpacer)


    @sidebar.addLayout(@horizontalLayout_2)

    @horizontalLayout_3 = Qt::HBoxLayout.new()
    @horizontalLayout_3.objectName = "horizontalLayout_3"
    @label_3 = Qt::Label.new(@centralwidget)
    @label_3.objectName = "label_3"
    @sizePolicy3 = Qt::SizePolicy.new(Qt::SizePolicy::Maximum, Qt::SizePolicy::Preferred)
    @sizePolicy3.setHorizontalStretch(0)
    @sizePolicy3.setVerticalStretch(0)
    @sizePolicy3.heightForWidth = @label_3.sizePolicy.hasHeightForWidth
    @label_3.sizePolicy = @sizePolicy3

    @horizontalLayout_3.addWidget(@label_3)

    @combo_rating_min = Qt::ComboBox.new(@centralwidget)
    @combo_rating_min.objectName = "combo_rating_min"
    @sizePolicy2.heightForWidth = @combo_rating_min.sizePolicy.hasHeightForWidth
    @combo_rating_min.sizePolicy = @sizePolicy2

    @horizontalLayout_3.addWidget(@combo_rating_min)

    @label_4 = Qt::Label.new(@centralwidget)
    @label_4.objectName = "label_4"
    @sizePolicy3.heightForWidth = @label_4.sizePolicy.hasHeightForWidth
    @label_4.sizePolicy = @sizePolicy3

    @horizontalLayout_3.addWidget(@label_4)

    @combo_rating_max = Qt::ComboBox.new(@centralwidget)
    @combo_rating_max.objectName = "combo_rating_max"
    @sizePolicy2.heightForWidth = @combo_rating_max.sizePolicy.hasHeightForWidth
    @combo_rating_max.sizePolicy = @sizePolicy2

    @horizontalLayout_3.addWidget(@combo_rating_max)


    @sidebar.addLayout(@horizontalLayout_3)

    @groupBox = Qt::GroupBox.new(@centralwidget)
    @groupBox.objectName = "groupBox"
    @sizePolicy2.heightForWidth = @groupBox.sizePolicy.hasHeightForWidth
    @groupBox.sizePolicy = @sizePolicy2
    @groupBox.styleSheet = "QGroupBox {\n" \
"	border: 1px solid gray;\n" \
"	border-radius: 5px;\n" \
"	margin: 1ex;\n" \
"	font-weight: bold;\n" \
"}\n" \
"QGroupBox::title {\n" \
"	subcontrol-origin: margin;\n" \
"	padding: 0 1px;\n" \
"	position: absolute;\n" \
"	left: 20px;\n" \
"}"
    @groupBox.flat = false
    @groupBox.checkable = false
    @gridLayout_2 = Qt::GridLayout.new(@groupBox)
    @gridLayout_2.spacing = 0
    @gridLayout_2.margin = 0
    @gridLayout_2.objectName = "gridLayout_2"
    @check_genres_all = Qt::CheckBox.new(@groupBox)
    @check_genres_all.objectName = "check_genres_all"

    @gridLayout_2.addWidget(@check_genres_all, 3, 1, 1, 1)

    @check_genres_action = Qt::CheckBox.new(@groupBox)
    @check_genres_action.objectName = "check_genres_action"
    @sizePolicy4 = Qt::SizePolicy.new(Qt::SizePolicy::Minimum, Qt::SizePolicy::Fixed)
    @sizePolicy4.setHorizontalStretch(0)
    @sizePolicy4.setVerticalStretch(0)
    @sizePolicy4.heightForWidth = @check_genres_action.sizePolicy.hasHeightForWidth
    @check_genres_action.sizePolicy = @sizePolicy4

    @gridLayout_2.addWidget(@check_genres_action, 4, 0, 1, 1)

    @check_genres_adventure = Qt::CheckBox.new(@groupBox)
    @check_genres_adventure.objectName = "check_genres_adventure"

    @gridLayout_2.addWidget(@check_genres_adventure, 4, 1, 1, 1)

    @check_genres_animation = Qt::CheckBox.new(@groupBox)
    @check_genres_animation.objectName = "check_genres_animation"

    @gridLayout_2.addWidget(@check_genres_animation, 5, 0, 1, 1)

    @check_genres_biography = Qt::CheckBox.new(@groupBox)
    @check_genres_biography.objectName = "check_genres_biography"

    @gridLayout_2.addWidget(@check_genres_biography, 5, 1, 1, 1)

    @check_genres_comedy = Qt::CheckBox.new(@groupBox)
    @check_genres_comedy.objectName = "check_genres_comedy"

    @gridLayout_2.addWidget(@check_genres_comedy, 6, 0, 1, 1)

    @check_genres_crime = Qt::CheckBox.new(@groupBox)
    @check_genres_crime.objectName = "check_genres_crime"

    @gridLayout_2.addWidget(@check_genres_crime, 6, 1, 1, 1)

    @check_genres_documentary = Qt::CheckBox.new(@groupBox)
    @check_genres_documentary.objectName = "check_genres_documentary"

    @gridLayout_2.addWidget(@check_genres_documentary, 7, 0, 1, 1)

    @check_genres_drama = Qt::CheckBox.new(@groupBox)
    @check_genres_drama.objectName = "check_genres_drama"

    @gridLayout_2.addWidget(@check_genres_drama, 7, 1, 1, 1)

    @check_genres_family = Qt::CheckBox.new(@groupBox)
    @check_genres_family.objectName = "check_genres_family"

    @gridLayout_2.addWidget(@check_genres_family, 8, 0, 1, 1)

    @check_genres_fantasy = Qt::CheckBox.new(@groupBox)
    @check_genres_fantasy.objectName = "check_genres_fantasy"

    @gridLayout_2.addWidget(@check_genres_fantasy, 8, 1, 1, 1)

    @check_genres_film_noir = Qt::CheckBox.new(@groupBox)
    @check_genres_film_noir.objectName = "check_genres_film_noir"

    @gridLayout_2.addWidget(@check_genres_film_noir, 9, 0, 1, 1)

    @check_genres_game_show = Qt::CheckBox.new(@groupBox)
    @check_genres_game_show.objectName = "check_genres_game_show"

    @gridLayout_2.addWidget(@check_genres_game_show, 9, 1, 1, 1)

    @check_genres_history = Qt::CheckBox.new(@groupBox)
    @check_genres_history.objectName = "check_genres_history"

    @gridLayout_2.addWidget(@check_genres_history, 10, 0, 1, 1)

    @check_genres_horror = Qt::CheckBox.new(@groupBox)
    @check_genres_horror.objectName = "check_genres_horror"

    @gridLayout_2.addWidget(@check_genres_horror, 10, 1, 1, 1)

    @check_genres_music = Qt::CheckBox.new(@groupBox)
    @check_genres_music.objectName = "check_genres_music"

    @gridLayout_2.addWidget(@check_genres_music, 11, 0, 1, 1)

    @check_genres_musical = Qt::CheckBox.new(@groupBox)
    @check_genres_musical.objectName = "check_genres_musical"

    @gridLayout_2.addWidget(@check_genres_musical, 11, 1, 1, 1)

    @check_genres_mystery = Qt::CheckBox.new(@groupBox)
    @check_genres_mystery.objectName = "check_genres_mystery"

    @gridLayout_2.addWidget(@check_genres_mystery, 12, 0, 1, 1)

    @check_genres_news = Qt::CheckBox.new(@groupBox)
    @check_genres_news.objectName = "check_genres_news"

    @gridLayout_2.addWidget(@check_genres_news, 12, 1, 1, 1)

    @check_genres_romance = Qt::CheckBox.new(@groupBox)
    @check_genres_romance.objectName = "check_genres_romance"

    @gridLayout_2.addWidget(@check_genres_romance, 13, 0, 1, 1)

    @check_genres_scifi = Qt::CheckBox.new(@groupBox)
    @check_genres_scifi.objectName = "check_genres_scifi"

    @gridLayout_2.addWidget(@check_genres_scifi, 13, 1, 1, 1)

    @check_genres_sport = Qt::CheckBox.new(@groupBox)
    @check_genres_sport.objectName = "check_genres_sport"

    @gridLayout_2.addWidget(@check_genres_sport, 14, 0, 1, 1)

    @check_genres_thriller = Qt::CheckBox.new(@groupBox)
    @check_genres_thriller.objectName = "check_genres_thriller"

    @gridLayout_2.addWidget(@check_genres_thriller, 14, 1, 1, 1)

    @check_genres_war = Qt::CheckBox.new(@groupBox)
    @check_genres_war.objectName = "check_genres_war"

    @gridLayout_2.addWidget(@check_genres_war, 15, 0, 1, 1)

    @check_genres_western = Qt::CheckBox.new(@groupBox)
    @check_genres_western.objectName = "check_genres_western"

    @gridLayout_2.addWidget(@check_genres_western, 15, 1, 1, 1)


    @sidebar.addWidget(@groupBox)

    @horizontalLayout_4 = Qt::HBoxLayout.new()
    @horizontalLayout_4.objectName = "horizontalLayout_4"
    @label_7 = Qt::Label.new(@centralwidget)
    @label_7.objectName = "label_7"
    @sizePolicy3.heightForWidth = @label_7.sizePolicy.hasHeightForWidth
    @label_7.sizePolicy = @sizePolicy3

    @horizontalLayout_4.addWidget(@label_7)

    @combo_sort = Qt::ComboBox.new(@centralwidget)
    @combo_sort.objectName = "combo_sort"
    @sizePolicy2.heightForWidth = @combo_sort.sizePolicy.hasHeightForWidth
    @combo_sort.sizePolicy = @sizePolicy2

    @horizontalLayout_4.addWidget(@combo_sort)

    @button_sort_inv = Qt::PushButton.new(@centralwidget)
    @button_sort_inv.objectName = "button_sort_inv"
    @sizePolicy.heightForWidth = @button_sort_inv.sizePolicy.hasHeightForWidth
    @button_sort_inv.sizePolicy = @sizePolicy
    @button_sort_inv.maximumSize = Qt::Size.new(40, 16777215)
    @button_sort_inv.checkable = true

    @horizontalLayout_4.addWidget(@button_sort_inv)


    @sidebar.addLayout(@horizontalLayout_4)

    @verticalSpacer = Qt::SpacerItem.new(20, 0, Qt::SizePolicy::Minimum, Qt::SizePolicy::Expanding)

    @sidebar.addItem(@verticalSpacer)

    @check_hide_seen = Qt::CheckBox.new(@centralwidget)
    @check_hide_seen.objectName = "check_hide_seen"
    @sizePolicy5 = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Minimum)
    @sizePolicy5.setHorizontalStretch(0)
    @sizePolicy5.setVerticalStretch(0)
    @sizePolicy5.heightForWidth = @check_hide_seen.sizePolicy.hasHeightForWidth
    @check_hide_seen.sizePolicy = @sizePolicy5

    @sidebar.addWidget(@check_hide_seen)

    @line = Qt::Frame.new(@centralwidget)
    @line.objectName = "line"
    @line.setFrameShape(Qt::Frame::HLine)
    @line.setFrameShadow(Qt::Frame::Sunken)

    @sidebar.addWidget(@line)

    @horizontalLayout_5 = Qt::HBoxLayout.new()
    @horizontalLayout_5.objectName = "horizontalLayout_5"
    @button_clear = Qt::PushButton.new(@centralwidget)
    @button_clear.objectName = "button_clear"
    @sizePolicy2.heightForWidth = @button_clear.sizePolicy.hasHeightForWidth
    @button_clear.sizePolicy = @sizePolicy2
    @button_clear.maximumSize = Qt::Size.new(16777215, 16777215)
    @button_clear.icon = icon11
    @button_clear.iconSize = Qt::Size.new(16, 16)
    @button_clear.default = false
    @button_clear.flat = false

    @horizontalLayout_5.addWidget(@button_clear)

    @button_find = Qt::PushButton.new(@centralwidget)
    @button_find.objectName = "button_find"
    @sizePolicy2.heightForWidth = @button_find.sizePolicy.hasHeightForWidth
    @button_find.sizePolicy = @sizePolicy2
    @button_find.acceptDrops = false
    @button_find.icon = icon1
    @button_find.iconSize = Qt::Size.new(16, 16)
    @button_find.autoRepeat = false
    @button_find.autoExclusive = false
    @button_find.autoDefault = false
    @button_find.default = false
    @button_find.flat = false

    @horizontalLayout_5.addWidget(@button_find)

    @button_cancel = Qt::PushButton.new(@centralwidget)
    @button_cancel.objectName = "button_cancel"
    @sizePolicy2.heightForWidth = @button_cancel.sizePolicy.hasHeightForWidth
    @button_cancel.sizePolicy = @sizePolicy2
    @button_cancel.icon = icon3
    @button_cancel.iconSize = Qt::Size.new(16, 16)

    @horizontalLayout_5.addWidget(@button_cancel)


    @sidebar.addLayout(@horizontalLayout_5)


    @horizontalLayout.addLayout(@sidebar)

    @scrollarea = Qt::ScrollArea.new(@centralwidget)
    @scrollarea.objectName = "scrollarea"
    @scrollarea.widgetResizable = true
    @scrollAreaWidgetContents = Qt::Widget.new()
    @scrollAreaWidgetContents.objectName = "scrollAreaWidgetContents"
    @scrollAreaWidgetContents.geometry = Qt::Rect.new(0, 0, 517, 547)
    @sizePolicy1.heightForWidth = @scrollAreaWidgetContents.sizePolicy.hasHeightForWidth
    @scrollAreaWidgetContents.sizePolicy = @sizePolicy1
    @verticalLayout_2 = Qt::VBoxLayout.new(@scrollAreaWidgetContents)
    @verticalLayout_2.objectName = "verticalLayout_2"
    @verticalSpacer_2 = Qt::SpacerItem.new(20, 40, Qt::SizePolicy::Minimum, Qt::SizePolicy::Expanding)

    @verticalLayout_2.addItem(@verticalSpacer_2)

    @scrollarea.setWidget(@scrollAreaWidgetContents)

    @horizontalLayout.addWidget(@scrollarea)

    main_window.centralWidget = @centralwidget
    @menubar = Qt::MenuBar.new(main_window)
    @menubar.objectName = "menubar"
    @menubar.geometry = Qt::Rect.new(0, 0, 800, 25)
    @menuFile = Qt::Menu.new(@menubar)
    @menuFile.objectName = "menuFile"
    @menuView = Qt::Menu.new(@menubar)
    @menuView.objectName = "menuView"
    @menuHelp = Qt::Menu.new(@menubar)
    @menuHelp.objectName = "menuHelp"
    main_window.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(main_window)
    @statusbar.objectName = "statusbar"
    main_window.statusBar = @statusbar

    @menubar.addAction(@menuFile.menuAction())
    @menubar.addAction(@menuView.menuAction())
    @menubar.addAction(@menuHelp.menuAction())
    @menuFile.addAction(@menu_find)
    @menuFile.addAction(@menu_next)
    @menuFile.addAction(@menu_cancel)
    @menuFile.addSeparator()
    @menuFile.addAction(@menu_to_see)
    @menuFile.addAction(@menu_seen)
    @menuFile.addAction(@menu_favourites)
    @menuFile.addSeparator()
    @menuFile.addAction(@menu_offline)
    @menuFile.addAction(@menu_exit)
    @menuView.addAction(@menu_elect_users)
    @menuView.addAction(@menu_edit_users)
    @menuView.addSeparator()
    @menuView.addAction(@menu_hide_sidebar)
    @menuView.addAction(@menu_clear)
    @menuHelp.addAction(@menu_about)

    retranslateUi(main_window)

    @combo_sort.setCurrentIndex(-1)


    Qt::MetaObject.connectSlotsByName(main_window)
    end # setupUi

    def setup_ui(main_window)
        setupUi(main_window)
    end

    def retranslateUi(main_window)
    main_window.windowTitle = Qt::Application.translate("main_window", "GIMDB", nil, Qt::Application::UnicodeUTF8)
    @menu_find.text = Qt::Application.translate("main_window", "&Find", nil, Qt::Application::UnicodeUTF8)
    @menu_next.text = Qt::Application.translate("main_window", "&Next", nil, Qt::Application::UnicodeUTF8)
    @menu_cancel.text = Qt::Application.translate("main_window", "&Cancel", nil, Qt::Application::UnicodeUTF8)
    @menu_to_see.text = Qt::Application.translate("main_window", "Show film to see", nil, Qt::Application::UnicodeUTF8)
    @menu_seen.text = Qt::Application.translate("main_window", "Show film seen", nil, Qt::Application::UnicodeUTF8)
    @menu_favourites.text = Qt::Application.translate("main_window", "Show favourites film", nil, Qt::Application::UnicodeUTF8)
    @menu_offline.text = Qt::Application.translate("main_window", "Work offiline", nil, Qt::Application::UnicodeUTF8)
    @menu_exit.text = Qt::Application.translate("main_window", "E&xit", nil, Qt::Application::UnicodeUTF8)
    @menu_elect_users.text = Qt::Application.translate("main_window", "Select users", nil, Qt::Application::UnicodeUTF8)
    @menu_edit_users.text = Qt::Application.translate("main_window", "&Edit users", nil, Qt::Application::UnicodeUTF8)
    @menu_hide_sidebar.text = Qt::Application.translate("main_window", "&Hide sidebar", nil, Qt::Application::UnicodeUTF8)
    @menu_clear.text = Qt::Application.translate("main_window", "C&lear", nil, Qt::Application::UnicodeUTF8)
    @menu_about.text = Qt::Application.translate("main_window", "&About", nil, Qt::Application::UnicodeUTF8)
    @line_edit_search.placeholderText = Qt::Application.translate("main_window", "Search", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("main_window", "Year", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("main_window", "to", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("main_window", "Vote", nil, Qt::Application::UnicodeUTF8)
    @label_4.text = Qt::Application.translate("main_window", "to", nil, Qt::Application::UnicodeUTF8)
    @groupBox.title = Qt::Application.translate("main_window", "Genres", nil, Qt::Application::UnicodeUTF8)
    @check_genres_all.text = Qt::Application.translate("main_window", "All", nil, Qt::Application::UnicodeUTF8)
    @check_genres_action.text = Qt::Application.translate("main_window", "Action", nil, Qt::Application::UnicodeUTF8)
    @check_genres_adventure.text = Qt::Application.translate("main_window", "Adventure", nil, Qt::Application::UnicodeUTF8)
    @check_genres_animation.text = Qt::Application.translate("main_window", "Animation", nil, Qt::Application::UnicodeUTF8)
    @check_genres_biography.text = Qt::Application.translate("main_window", "Biography", nil, Qt::Application::UnicodeUTF8)
    @check_genres_comedy.text = Qt::Application.translate("main_window", "Comedy", nil, Qt::Application::UnicodeUTF8)
    @check_genres_crime.text = Qt::Application.translate("main_window", "Crime", nil, Qt::Application::UnicodeUTF8)
    @check_genres_documentary.text = Qt::Application.translate("main_window", "Documentary", nil, Qt::Application::UnicodeUTF8)
    @check_genres_drama.text = Qt::Application.translate("main_window", "Drama", nil, Qt::Application::UnicodeUTF8)
    @check_genres_family.text = Qt::Application.translate("main_window", "Family", nil, Qt::Application::UnicodeUTF8)
    @check_genres_fantasy.text = Qt::Application.translate("main_window", "Fantasy", nil, Qt::Application::UnicodeUTF8)
    @check_genres_film_noir.text = Qt::Application.translate("main_window", "Film noir", nil, Qt::Application::UnicodeUTF8)
    @check_genres_game_show.text = Qt::Application.translate("main_window", "Game show", nil, Qt::Application::UnicodeUTF8)
    @check_genres_history.text = Qt::Application.translate("main_window", "History", nil, Qt::Application::UnicodeUTF8)
    @check_genres_horror.text = Qt::Application.translate("main_window", "Horror", nil, Qt::Application::UnicodeUTF8)
    @check_genres_music.text = Qt::Application.translate("main_window", "Music", nil, Qt::Application::UnicodeUTF8)
    @check_genres_musical.text = Qt::Application.translate("main_window", "Musical", nil, Qt::Application::UnicodeUTF8)
    @check_genres_mystery.text = Qt::Application.translate("main_window", "Mystery", nil, Qt::Application::UnicodeUTF8)
    @check_genres_news.text = Qt::Application.translate("main_window", "News", nil, Qt::Application::UnicodeUTF8)
    @check_genres_romance.text = Qt::Application.translate("main_window", "Romance", nil, Qt::Application::UnicodeUTF8)
    @check_genres_scifi.text = Qt::Application.translate("main_window", "SciFi", nil, Qt::Application::UnicodeUTF8)
    @check_genres_sport.text = Qt::Application.translate("main_window", "Sport", nil, Qt::Application::UnicodeUTF8)
    @check_genres_thriller.text = Qt::Application.translate("main_window", "Thriller", nil, Qt::Application::UnicodeUTF8)
    @check_genres_war.text = Qt::Application.translate("main_window", "War", nil, Qt::Application::UnicodeUTF8)
    @check_genres_western.text = Qt::Application.translate("main_window", "Western", nil, Qt::Application::UnicodeUTF8)
    @label_7.text = Qt::Application.translate("main_window", "Sort", nil, Qt::Application::UnicodeUTF8)
    @button_sort_inv.text = Qt::Application.translate("main_window", "Inv", nil, Qt::Application::UnicodeUTF8)
    @check_hide_seen.text = Qt::Application.translate("main_window", "Hide film seen", nil, Qt::Application::UnicodeUTF8)
    @button_clear.text = Qt::Application.translate("main_window", "C&lear", nil, Qt::Application::UnicodeUTF8)
    @button_find.text = Qt::Application.translate("main_window", "&Find", nil, Qt::Application::UnicodeUTF8)
    @button_cancel.text = Qt::Application.translate("main_window", "&Cancel", nil, Qt::Application::UnicodeUTF8)
    @menuFile.title = Qt::Application.translate("main_window", "File", nil, Qt::Application::UnicodeUTF8)
    @menuView.title = Qt::Application.translate("main_window", "View", nil, Qt::Application::UnicodeUTF8)
    @menuHelp.title = Qt::Application.translate("main_window", "Help", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(main_window)
        retranslateUi(main_window)
    end

end

module Ui
    class Main_window < Ui_Main_window
    end
end  # module Ui

