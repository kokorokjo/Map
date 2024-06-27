#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QMouseEvent>
#include <QEvent>
#include <QCompleter>
#include <QtWidgets>
#include <QLineEdit>



QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();



private:
    Ui::MainWindow *ui;
    void mousePressEvent(QMouseEvent *event) override;

private slots:
    void showCompleter();

private:
    QMenu *contextMenu;
    QLineEdit *completerLineEdit;
    QCompleter *completer;

    // QStringListModel *model;
    QListView *completerPopup;

    QStandardItemModel *model;


};

#endif // MAINWINDOW_H
