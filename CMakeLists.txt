cmake_minimum_required(VERSION 3.16)

project(Namaz VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appNamaz
    main.cpp
    resources.qrc
)

qt_add_qml_module(appNamaz
    URI Namaz
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES
        SOURCES
        QML_FILES
        QML_FILES
        SOURCES
        SOURCES
        SOURCES
        QML_FILES
        SOURCES
        SOURCES
        RESOURCES
        SOURCES
        SOURCES
        RESOURCES
        SOURCES settingswrapper.h
        SOURCES settingswrapper.cpp
        QML_FILES
        QML_FILES
        QML_FILES
        RESOURCES resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appNamaz PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appNamaz
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appNamaz
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appNamaz
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
