#include "mainwindow.h"
#include "ui_mainwindow.h"

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

QStringList symbols ={"Assumed Friendly","Assumed Hostile","Unknown","Neutral"};
QStringList iconPaths = {":/Infantry_MGRS-Mapper.svg",":/Armored-Track-Unit_MGRS-Mapper.svg",":/Information-Operations_MGRS-Mapper.svg",":/Interpreter_Translator_MGRS-Mapper.svg"};

QPoint nieco;


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);



    //map
    ui->quickWidget->setSource(QUrl(QStringLiteral("qrc:/map.qml")));
    ui->quickWidget->show();

    auto obj = ui->quickWidget->rootObject();
    // connect(this,SIGNAL(setCenter(QVariant,QVariant)),obj,SLOT(setCenter(QVariant,QVariant)));
    connect(this,SIGNAL(setMarker(QVariant,QVariant,QVariant)),obj,SLOT(setMarker(QVariant,QVariant,QVariant)));

    // emit setCenter(48.149,17.108);


    // qmenu
    contextMenu = new QMenu(this);
    completerLineEdit =new QLineEdit(this);
    completerLineEdit->hide();

    model = new QStandardItemModel(this);

    for(int i=0;i<symbols.size();i++){
        auto col1= new QStandardItem(QIcon(iconPaths[i]),symbols[i]);
        auto col2= new QStandardItem(symbols[i]);
        model->appendRow(QList<QStandardItem*>()<<col1<<col2);
    }

    completer = new QCompleter(this);
    completer-> setModel(model);
    completer-> setModelSorting(QCompleter::CaseSensitivelySortedModel);
    completer-> setCaseSensitivity(Qt::CaseInsensitive);
    completer-> setCompletionMode(QCompleter::PopupCompletion);

    completerLineEdit->setCompleter(completer);

    connect(completer, QOverload<const QModelIndex &>::of(&QCompleter::activated),
            this, &MainWindow::handleCompletion);


    // uplne randomne
    QAction *chooseSymbolAction = new QAction("Choose Symbol", this);
    connect(chooseSymbolAction,&QAction::triggered, this, &MainWindow::showCompleter);
    contextMenu->addAction(chooseSymbolAction);
}


MainWindow::~MainWindow()
{
    delete ui;
}



void MainWindow::mousePressEvent(QMouseEvent *event){
    if (event->button() == Qt::RightButton) {
        QMenu menu;
        QAction* a1 = menu.addAction(QString("test1"));
        QAction* a2 = menu.addAction(QString("test2"));
        if(a1 == menu.exec(QCursor::pos())) {


            qInfo() << "C++ a2 Info Message";
            contextMenu->exec(event->globalPos());



        }
        else if(a2 == menu.exec(QCursor::pos())) {
            qInfo() << "C++ a1 Info Message";
        }
        // menu.exec(QCursor::pos());
        qInfo() << "C++ Style Info Message";
        qInfo() << event->pos();
        nieco=event->pos();
        // double y=nieco.y();
        // double x=nieco.x();





    }

}

void MainWindow::showCompleter(){
    completerLineEdit->move(contextMenu->pos());
    completerLineEdit->show();
    completerLineEdit->setFocus();
}

void MainWindow::handleCompletion(const QModelIndex &index) {
    // QStandardItem *item = model->itemFromIndex(index);
    qInfo() << "Selected option index:"<<index.row();
    int r=index.row();
    qInfo() << symbols[r]<<" "<<"qrc"+iconPaths[r];
    completerLineEdit->hide();
    emit setMarker(48.149,17.108,"qrc"+iconPaths[r]);
}
