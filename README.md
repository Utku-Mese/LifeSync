# LifeSync

- [Türkçe(TR)](#türkçe)
- [English(EN)](#english)


# Türkçe
<br>

## İçerik

- [Genel Bakış](#genel-bakış)
- [Ekran Görüntüleri](#uygulama-içi-ekran-görüntüleri)
- [Özellikler](#özellikler)
- [Başlangıç](#başlangıç)
  - [Gereklilikler](#gereklilikler)
  - [Kurulum](#kurulum)
- [Lisans](#lisans)

## Genel Bakış

LifeSync, kullanıcıların günlük yaşantılarını düzenleyerek sağlıklı bir 
yaşam sürmelerine katkıda bulunmayı amaçlamaktadır. Proje, 
kullanıcıların beslenme, spor ve su tüketimi gibi önemli faktörleri takip 
etmelerine olanak tanıyan çok platformlu bir sistemdir. Ayrıca, 
kullanıcıları birbirleriyle etkileşime geçirerek motivasyonlarını artırmak 
ve sağlıklı yaşam alışkanlıkları kazandırmak için çeşitli özellikleri 
içermektedir. LifeSync, kullanıcıların günlük hedefleri belirlemelerine, 
bu hedeflere ulaşmalarına ve birbirleriyle rekabet etmelerine olanak 
tanıyan bir platform sunmaktadır. 

<br>

API varsayılan olarak 8000 numaralı bağlantı noktasında çalışır.

API'ye http://localhost:8000/ adresinden erişebilirsiniz.

Not: API, veritabanı tabloları eklenmeden çalışmaz.

## Uygulama içi ekran görüntüleri

devam ediyor...

## Özellikler

devam ediyor...

## MVC Mimarisi

Bu projede MVC (Model-View-Controller) mimarisi kullanılmıştır. Bu mimari sayesinde projenin geliştirilmesi, düzenlenmesi ve bakımı kolaylaştırılmıştır. Model, View ve Controller bileşenleri, uygulamayı yönetmek için sağlam ve bakımı kolay bir sistem sağlamak üzere uyumlu bir şekilde çalışmaktadır.

## Başlangıç

### Gereklilikler

Başlamadan önce aşağıdaki gereksinimleri karşıladığınızdan emin olun:

- Bilgisayarınızda Node.js, npm ve flutter yüklü olmalı.
- Uygun tablolar ve konfigürasyona sahip MySQL veritabanınız olmalı.
- Bu projeyi bilgisayarınıza kopyalamalısınız.

### Kurulum

Projeyi yüklemek ve çalıştırmak için şu adımları izleyin:

1. "database" klasörüne git:

   ```shell
   cd LifeSync/backend

2. Proje bağımlılıklarını yükleyin:

    ```shell
    npm install

3. Veritabanı ayarlarını düzenle:

* "config.js" dosyasını aç ve MySQL veritabanı bilgilerini düzenle.

4. Sunucuyu başlat:

    ```shell
    node index.js

    ```
    ya da
    ```shell
    npm start
    
5. Proje dizinine git:

    ```shell
    cd ..

6. "flutter pub get" komutunu çalıştırarak paketleri yükle:

    ```shell
    flutter pub get

7. Uygulamayı başlat:

    ```shell
    flutter run

## Lisans

Bu proje [MIT Lisansı](/LICENSE) kapsamında lisanslanmıştır.


<br>
<hr>
<hr>
<br>

# English
<br>
## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [In App Screenshots](#in-app-screenshots)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [License](#license)

## Overview

LifeSync aims to contribute to users leading a healthy life by organizing their daily routines. The project is a multi-platform system that allows users to track essential factors such as nutrition, exercise, and water consumption. Additionally, it includes various features to engage users with each other, boosting their motivation and instilling healthy lifestyle habits. LifeSync provides a platform for users to set daily goals, achieve them, and compete with each other.

<br>

The API runs on port 8000 by default.

You can access the API at http://localhost:8000/

Note: API does not work without adding database tables.

## In App Screenshots

progressing...

## Features

progressing...

## MVC Architecture

This project follows the MVC (Model-View-Controller) architectural pattern, which helps in organizing and managing the codebase effectively. By adhering to the MVC architecture, the project achieves a clear separation of concerns, making it easier to manage and extend in the future. The Model, View, and Controller components collaborate harmoniously to provide a robust and maintainable system for managing app.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Node.js, npm and flutter installed on your development machine.
- MySQL database with appropriate tables and configuration.
- Clone this repository to your local machine.

### Installation

To install and run the project locally, follow these steps:

1. Navigate to the database directory:

   ```shell
   cd LifeSync/backend

2. Install the project dependencies:

    ```shell
    npm install

3. Configure the database settings:

* Open the config.js file and set your MySQL database connection details.

4. Start the server:

    ```shell
    node index.js

    ```
    or
    ```shell
    npm start
    
5. Navigate to the project directory:

    ```shell
    cd ..

6. run "flutter pub get":

    ```shell
    flutter pub get

7. Start the application:

    ```shell
    flutter run

## License

This project is licensed under the [MIT License](/LICENSE).


