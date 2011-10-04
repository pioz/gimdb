all: ui_main_window.rb ui_statusbar.rb ui_icons.rcc
ui_main_window.rb: main_window.ui
	rbuic4 main_window.ui -o ui_main_window.rb
ui_statusbar.rb: statusbar.ui
	rbuic4 statusbar.ui -o ui_statusbar.rb
ui_icons.rcc: icons.qrc
	rbrcc icons.qrc -o ui_icons.rb
