#include <QApplication>
#include <QMainWindow>
#include <QScreen>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    
    // Получаем разрешение экрана
    QScreen *screen = QGuiApplication::primaryScreen();
    QSize screenSize = screen->size();

    // Вычисляем размеры окна в зависимости от разрешения экрана
    int width = screenSize.width() * 0.4;  // 40% от ширины экрана
    int height = screenSize.height() * 0.4; // 40% от высоты экрана

    QMainWindow window;
    window.resize(width, height);
    window.setWindowTitle("Простое окно Qt");
    window.show();
    
    return app.exec();
}
