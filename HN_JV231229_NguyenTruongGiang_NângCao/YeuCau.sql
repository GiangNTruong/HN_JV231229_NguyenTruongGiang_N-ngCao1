use quanlybanhang;
insert into customers(customer_id, name, email, phone, address)
VALUES ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
       ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984875926', 'Ba Vì, Hà Nội'),
       ('C003', 'Tô Ngọc Vũ', 'vutri@gmail.com', '904725784', 'Mộc Châu , Sơn La'),
       ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vĩnh, Nghệ An'),
       ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trưng, Hà Nội');

insert into products(product_id, name, description, price)
values ('P001', 'Iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999),
       ('P002', 'Dell Votro V3510', 'Core i5, Ram 8GB', 14999999),
       ('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256GB', 28999999),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999),
       ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000);

insert into orders (order_id, customer_id, total_amount, order_date)
values ('H001', 'C001', 52999997, '2023-2-22'),
       ('H002', 'C001', 80999997, '2023-3-11'),
       ('H003', 'C002', 54359998, '2023-1-22'),
       ('H004', 'C003', 102999995, '2023-3-14'),
       ('H005', 'C003', 80999997, '2023-3-12'),
       ('H006', 'C004', 110449994, '2023-2-1'),
       ('H007', 'C004', 79999996, '2023-3-29'),
       ('H008', 'C005', 29999998, '2023-2-14'),
       ('H009', 'C005', 28999999, '2023-1-10'),
       ('H010', 'C005', 149999994, '2023-4-1');

insert into orders_details (order_id, product_id, price, quantity)
values ('H001', 'P002', 14999999, 1),
       ('H001', 'P004', 18999999, 2),

       ('H002', 'P001', 22999999, 1),
       ('H002', 'P003', 28999999, 2),

       ('H003', 'P004', 18999999, 2),
       ('H003', 'P005', 4090000, 4),

       ('H004', 'P002', 14999999, 3),
       ('H004', 'P003', 28999999, 2),

       ('H005', 'P001', 22999999, 1),
       ('H005', 'P003', 28999999, 2),

       ('H006', 'P005', 4090000, 5),
       ('H006', 'P002', 14999999, 6),

       ('H007', 'P004', 18999999, 3),
       ('H007', 'P001', 22999999, 1),

       ('H008', 'P002', 14999999, 2),
       ('H009', 'P003', 28999999, 1),

       ('H010', 'P003', 28999999, 2),
       ('H010', 'P001', 22999999, 4);

# Bài 3: Truy vấn dữ liệu [30 điểm]
# Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .
# [4 điểm]
select name as tên, email, phone as 'Số điện thoại', address as 'Địa chỉ'
from customers;
# 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
# thoại và địa chỉ khách hàng). [4 điểm]
select distinct c.name, c.phone as 'so điện thoại', c.address as 'địa chỉ khách hàng'
from orders
         join customers c on c.customer_id = orders.customer_id
where month(order_date) = 3
  and year(order_date) = 2023;

# 3. Thống kê doanh thu theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm
# tháng và tổng doanh thu ). [4 điểm]
select month(order_date) tháng, sum(total_amount) as 'Tổng doanh thu'
from orders
where year(order_date) = 2023
group by tháng;

# 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách
# hàng, địa chỉ , email và số điên thoại). [4 điểm]
select name, address, email, phone
from customers
where customer_id not in
      (select customer_id
       from orders
       where month(order_date) = 2
         and year(order_date) = 2023);

# 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã
# sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
select p.product_id as 'Mã sản phẩm', name, sum(od.quantity) as 'số lượng bán ra'
from products p
         join orders_details od on p.product_id = od.product_id
         join orders o on o.order_id = od.order_id
where month(order_date) = 3
  and year(order_date) = 2023
group by p.product_id, name;


# 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi
# tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
select c.customer_id as 'mã khách hàng', name 'tên', sum(o.total_amount) as 'mức chi tiêu năm 2023'
from customers c
         join orders o on c.customer_id = o.customer_id
where year(o.order_date) = 2023
group by c.customer_id, name
order by sum(o.total_amount) desc;

# 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm
# tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]
select c.name           as 'tên người mua',
       o.total_amount   as 'tổng tiền',
       o.order_date     as ' ngày tạo hoá đơn',
       sum(od.quantity) as 'tổng số lượng sản phẩm'
from orders_details od
         join orders o on od.order_id = o.order_id
         join customers c on c.customer_id = o.customer_id
group by o.order_id
having sum(od.quantity) >= 5;

# Bài 4: Tạo View, Procedure [30 điểm]:

# 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng
# tiền và ngày tạo hoá đơn . [3 điểm]
create view ORDERS_VIEW as
select name, phone, address, o.total_amount as 'Tổng Tiền', o.order_date as 'Ngày tạo'
from customers c
         join orders o on c.customer_id = o.customer_id;

# 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng
# số đơn đã đặt. [3 điểm]
create view CUSTOMER_VIEW as
select name, address, phone, count(o.order_id) as 'Tổng số đơn đã đặt'
from customers c
         left join orders o on c.customer_id = o.customer_id
group by c.customer_id,
         c.name,
         c.address,
         c.phone;


# 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã
# bán ra của mỗi sản phẩm.
create view PRODUCTS_VIEW as
select name, description, p.price, sum(od.quantity) as 'tổng số lượng đã bán ra của mỗi sản phẩm'
from products p
         join orders_details od on p.product_id = od.product_id
group by p.product_id;


# 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
create index idx_phone on customers (phone);
create index idx_email on customers (email);

# 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
delimiter &&
create procedure GET_CUSTOMER_DETAILS(customer_id_input varchar(4))
begin
    select * from customers where customer_id = customer_id_input;
end &&
delimiter ;
call GET_CUSTOMER_DETAILS('C001');
# 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
delimiter &&
create procedure GET_ALL_PRODUCT()
BEGIN
    SELECT * FROM products;
end &&
delimiter ;
call GET_ALL_PRODUCT();

# 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
delimiter &&
create procedure GET_ORDER_TO_USER(order_id_input_user varchar(4))
begin
    select *
    from orders
    where customer_id = order_id_input_user;
end &&
delimiter ;
call GET_ORDER_TO_USER('C001');
# 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
# tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
delimiter &&
create procedure CREATE_NEW_ORDER_VIEW(
    order_id_input varchar(4),
    customer_id_input varchar(4),
    total_amount_input double,
    order_date_input date

)
begin
    insert into orders (order_id,customer_id, total_amount, order_date)
    values ( order_id_input,customer_id_input,total_amount_input,order_date_input);
end &&
delimiter ;



# 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
# thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]

delimiter &&
create procedure COUNT_PRODUCTS_SOLD(start_date date, end_date date)
begin
    select product_id, sum(quantity) AS 'Số lượng bán'
    from ORDERS_DETAILS
    where order_id in (select order_id from Orders where order_date between start_date and end_date)
    group by product_id;
end &&
delimiter ;
call COUNT_PRODUCTS_SOLD('2023-02-1', '2023-2-28');

# 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
# giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]

delimiter &&
create procedure COUNT_PRODUCTS_SOLD_MONTHLY(input_month int, input_year int)
begin
    select product_id, sum(quantity) as 'Số lợng của mỗi sản phẩm được bán'
    from orders_details
    where order_id in
          (select order_id from orders where month(order_date) = input_month and year(order_date) = input_year)
    group by product_id
    order by sum(quantity) desc;

end &&
delimiter ;
call COUNT_PRODUCTS_SOLD_MONTHLY(02, 2023);





-- -----------------------------------------------------------
DELIMITER &&
CREATE PROCEDURE CREATE_NEW_ORDER_VIEW2(
    customer_id_input VARCHAR(4),
    total_amount_input DOUBLE,
    order_date_input DATE,
    OUT order_id_out VARCHAR(4)
)
BEGIN
    DECLARE max_id INT;
    DECLARE new_id VARCHAR(4);

    -- Tách phần số từ order_id hiện tại lớn nhất
    SELECT CAST(SUBSTRING(MAX(order_id), 2) AS UNSIGNED) INTO max_id
    FROM orders;

    -- Tăng giá trị này lên 1 để tạo ID mới
    SET max_id = max_id + 1;

    -- Nối 'H' với giá trị mới để tạo order_id mới
    SET new_id = CONCAT('H', LPAD(max_id, 3, '0'));

    -- Chèn đơn hàng mới với order_id mới
    INSERT INTO orders (order_id, customer_id, total_amount, order_date)
    VALUES (new_id, customer_id_input, total_amount_input, order_date_input);

    -- Trả về order_id mới
    SET order_id_out = new_id;
    SELECT order_id_out;
END &&
DELIMITER ;

CALL CREATE_NEW_ORDER_VIEW2('C001', 11111111111, '2023-03-30', @order_id);
SELECT @order_id;
