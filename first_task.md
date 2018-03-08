# نصب گیتب
بهتر است ابتدا دستور زیر اجرا شود
```
sudo apt-get update
```
### وارد کردن دستور نصب گیت به صورت زیر در خط فرمان
```git
sudo apt install git
```
### پیکربندی گیت
دراین گام یک آدرس میل و یک نام کاربری وارد می کنیم
```git
git cofig --global user.name "you@example.com"
git cofig --global user.name "your name "
```
# شروع کار با گیت
ساخت دایرکتوری به نام 12factor
```
mkdir 12factor
```
وارد شدن به دایرکتوری وساخت empty local repository:
```
cd 12factor
git init .
```
اضافه کردن برنامه پایتون نوشته شده که در مسیر دایرکتوری 12factor قرار گرفته است، به local repository و commit کردن آن:
```
git add app.py
git commit -m "initial commit"
```
در مسیر دایرکتوری یک فایل متنی با نام requirements ایجاد کرده ایم که باید در آن ن که در آن نام فایل های مورد نیاز را می نویسیم 
```
echo flask >> requirements.txt
```
___
پس از انجام این مراحل به سراغ Dockerfile میرویم.این فایل یک فایل متنی است که در آن دستورات زیر نوشته می شود.این فایل در مسیر دایرکتوری ساخته شده قرار دارد.
```
FROM python:latest 
RUN apt-get update
COPY . /requirements.txt
COPY . /opt/app
WORKDIR /opt/app
RUN pip install -r requirements.txt
CMD["python","./app.py"]
```
با این دستورتصویری از آخرین نسخه پایتون برای ما فراهم می‌شود
```
FROM python:latest 
```
با این دستور به روز رسانی بسته ‌ها انجام می‌گیرد
```
 RUN apt-get update
```
برای ایجاد یک کپی از فایل‌ها استفاده می‌شود
```
 COPY . /requirements.txt
 COPY . /opt/app
```
دستور RUN یک دستور مرکزی برای Dokerfile  است که یک یک دستور را به عنوان ورودی ریافت می‌کند و آن را برای ساخت تصویر اجرا می‌کند.
```
RUN pip install -r requirements.txt
```
براین تعیین نحوه اجرای فرمان با CMD  به کار می‌رود

```
WORKDIR /opt/app
```
اجری یک برنامه کاربردی روی Container موجود
```
CMD["python","./app.py"]
```
# ساخت Container
پیش از نصب کانتینر باید ابتدا از فایل سرویس خود بکاپ تهیه نمائيد تا در صورت بروز مشکل اقدام به بازگردانی فایل نمایید.
```
cp /etc/systemd/system/multi-user.target.wants/docker.service  /etc/systemd/system/multi-user.target.wants
```
در این مرحله با ستور `sudo vim docker.service` وارد docker.service می‌شویم ودر مقابل `ExecStart` عبارت زیر را جایگزین می‌کنیم


```
/usr/bin/dockerd --registry-mirror=http://repo.docker.ir:5000
```
پس از آن که خط بالا را اضافه نمودید سرویس داکر را ریست می کنیم.
```
systemctl daemon-reload                       
systemctl restart docker
```
سپس به نصب فایل‌های image خود می‌پردازیم
```
docker pull busybox
```
برای ساخت هر image پایه از دستور بال استفاده می‌کنیم.
ساخت 
# ساخت Container از DOckerfile
همان طور که قبلا توضیح داده شد Dockerfile ساخته می شود.حال به مسیر این فایل رفته و دستوور زیر را اجرا میکنیم تا Contaier ای به اسم my_container ساخته شود.
```
sudo docker build . -t my_container 
```
بعد از ساخته شده container مورد نظر آن را اجرا می‌کنیم
```sudo docker run my_container
```
سپس در خروجی یک آدرس http  نمایش داده میشود که اگر این آدرس را در مرورگر خود وار کنیم خروجی برنامه نوشته شده در app .py نمایش داده می شود.

