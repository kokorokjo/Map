#include "mainwindow.h"


#include <QUrl>
#include <QQuickWidget>
#include <QMenu>
#include <QMouseEvent>
#include <QDebug>
#include <QCompleter>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperties>

#include <QApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QQuickItem>
#include <QQmlComponent>
#include <QtPositioning/QGeoCoordinate>
#include <QQmlApplicationEngine>

QStringList symbols ={"Assumed Friendly","Assumed Hostile","Unknown","Neutral"};
QStringList iconPaths = {":/Infantry_MGRS-Mapper.svg",":/Armored-Track-Unit_MGRS-Mapper.svg",":/Information-Operations_MGRS-Mapper.svg",":/Interpreter_Translator_MGRS-Mapper.svg"};

QPoint nieco;

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    // , em(new EngineManager)
{

    // auto obj =em->engine()->rootObjects();
    // QQmlApplicationEngine *engine("main.qml");
    // engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    // QObject *obj = engine.rootObjects().first();

    // connect(this,SIGNAL(setMarker(QVariant,QVariant,QVariant)),obj,SLOT(setMarker(QVariant,QVariant,QVariant)));
    // connect(this,SIGNAL(getMousePosition(QVariant,QVariant)),obj,SLOT(getMousePosition(QVariant,QVariant)));

    contextMenu = new QMenu(this);
    completerLineEdit =new QLineEdit(this);
    completerLineEdit->hide();

    model = new QStandardItemModel(this);

    for(int i=0;i<symbols.size();i++){
        auto col1= new QStandardItem(QIcon(iconPaths[i]),symbols[i]);
        col1->setData(iconPaths[i],Qt::UserRole + 1);
        model->appendRow(QList<QStandardItem*>()<<col1);
    }

    completer = new QCompleter(this);
    completer-> setModel(model);
    completer-> setModelSorting(QCompleter::CaseSensitivelySortedModel);
    completer-> setCompletionRole(Qt::DisplayRole);
    completer-> setCaseSensitivity(Qt::CaseInsensitive);
    completer-> setCompletionMode(QCompleter::PopupCompletion);

    completerLineEdit->setCompleter(completer);

    connect(completer, QOverload<const QString &>::of(&QCompleter::activated),
            this, &MainWindow::onCompleterActivated);


}

MainWindow::~MainWindow() {}

void MainWindow::onCompleterActivated(const QString &text) {
    QString iconPath;
    for (int i = 0; i < model->rowCount(); ++i) {
        QStandardItem *item = model->item(i);
        if (item->text() == text) {
            iconPath = item->data(Qt::UserRole + 1).toString();
            qDebug() << "Completer Selected Text:" << text;
            qDebug() << "Completer Icon Path:" << iconPath;
            // Perform additional actions if needed
            break;
        }
    }
    completerLineEdit->hide();
    completerLineEdit->clear();
    emit setMarker(48.149,17.108,"qrc"+iconPath);

}




void MainWindow::mousePressEvent(QMouseEvent *event){
    if (event->button() == Qt::RightButton) {
        emit getMousePosition(QCursor::pos().x(),QCursor::pos().y());

        QMenu menu;
        QAction* a1 = menu.addAction(QString("Add Unit"));
        QAction* a2 = menu.addAction(QString("test2"));
        if(a1 == menu.exec(QCursor::pos())) {


            // qInfo() << "C++ a2 Info Message";
            showCompleter();



        }
        else if(a2 == menu.exec(QCursor::pos())) {
            qInfo() << "C++ a1 Info Message";
        }
        // qInfo() << "C++ Style Info Message";
        // qInfo() << event->pos();
        nieco=event->pos();

    }

}

void MainWindow::showCompleter(){
    completerLineEdit->move(contextMenu->pos());
    completerLineEdit->show();
    completerLineEdit->setFocus();
}


