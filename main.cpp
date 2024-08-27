#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ClockManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ClockManager clockManager;
    engine.rootContext()->setContextProperty("clockManager", &clockManager);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Namaz", "Main");

    return app.exec();
}
