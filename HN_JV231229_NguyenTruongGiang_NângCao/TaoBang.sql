create database QuanLyBanHang;
use QuanLyBanHang;
create table customers (
    customer_id varchar(4) primary key not null ,
    name varchar(100) not null ,
    email varchar(100) unique not null ,
    phone varchar(25) unique not null ,
    address varchar(255) not null
);

create table Orders (
  order_id varchar(4) primary key not null ,
    customer_id varchar(4) not null ,
    total_amount double not null,
  order_date date not null
);

create table Products (
    product_id varchar(4) primary key not null ,
    name varchar(255) not null ,
    description text,
    price double not null ,
    status bit(1) not null default 1
);

create table ORDERS_DETAILS(
  order_id  varchar(4) not null  ,
    product_id varchar(4) not null ,
    price double not null,
  quantity int(11) not null ,
    primary key (order_id,product_id)
);

alter table Orders
add foreign key (customer_id) references customers (customer_id);

alter table ORDERS_DETAILS
add foreign key (order_id) references Orders (order_id),
    add foreign key (product_id) references  Products(product_id);

