-- 1. Schema 'Ecommerce & table creation
-- 
create database Ecommerce ;
create table Supplier(SUPP_ID INT PRIMARY KEY , SUPP_NAME VARCHAR(50) NOT NULL , SUPP_CITY VARCHAR(50) NOT NULL , SUPP_PHONE VARCHAR(50) NOT NULL );
create table customer(CUS_ID INT PRIMARY KEY , CUS_NAME VARCHAR(50) NOT NULL ,CUS_PHONE VARCHAR(50) NOT NULL, CUS_CITY VARCHAR(50) NOT NULL , CUS_GENDER CHAR );
create table category(CAT_ID INT PRIMARY KEY , CAT_NAME VARCHAR(20) NOT NULL );
create table product(PRO_ID INT PRIMARY KEY , PRO_NAME VARCHAR(20) NOT NULL , PRO_DESC VARCHAR(60),  CAT_ID INT,FOREIGN KEY (CAT_ID) REFERENCES category(CAT_ID)) ;
create table supplier_pricing(PRICING_ID INT PRIMARY KEY ,PRO_ID INT, FOREIGN KEY (PRO_ID) REFERENCES product(PRO_ID) ,SUPP_ID INT ,FOREIGN KEY (SUPP_ID) REFERENCES supplier(SUPP_ID),SUPP_PRICE INT );
create table ordertable(ORD_ID INT PRIMARY KEY , ORD_AMOUNT INT NOT NULL , ORD_DATE DATE NOT NULL ,CUS_ID INT,FOREIGN KEY (CUS_ID) REFERENCES customer(CUS_ID) ,PRICING_ID INT,FOREIGN KEY (PRICING_ID) REFERENCES supplier_pricing(PRICING_ID) );
create table rating(RAT_ID INT PRIMARY KEY , ORD_ID INT ,FOREIGN KEY (ORD_ID) REFERENCES ordertable(ORD_ID), RAT_RATSTARS INT NOT NULL) ;
-- 2.Putting Entries in the Table
use Ecommerce;
insert into Supplier values(1,'Rajesh Retails','Delhi',1234567890);
insert into Supplier values(2,'Appario Ltd','Mumbai',2589631470);
insert into Supplier values(3,'Knome products','Bangalore',9785462315);
insert into Supplier values(4,'Bansal Retails','Kochi',8975463285);
insert into Supplier values(5,'Mittal Ltd','Lucknow',7898456532);

insert into customer values(1,'AAKASH',9999999999,'DELHI','M');
insert into customer values(2,'AMAN',9785463215,'NOIDA','M');
insert into customer values(3,'NEHA',9999999999,'MUMBAI','F');
insert into customer values(4,'MEGHA',9994562399,'KOLKATA','F');
insert into customer values(5,'PULKIT',7895999999,'LUCKNOW','M');

insert into category values(1,'BOOKS');
insert into category values(2,'GAMES');
insert into category values(3,'GROCERIES');
insert into category values(4,'ELECTRONICS');
insert into category values(5,'CLOTHES');

insert into product values(1,'GTA V','Windowa 7 and above with i5 processor and 8GB RAM',2);
insert into product values(2,'TSHIRT','SIZE-L with Black , Blue and White Variations',5);
insert into product values(3,'ROG LAPTOP','Windows10 with 15in Screen , i7Processor , 1TB SSD',4);
insert into product values(4,'OATS','Highly Nutritious from Nestle',3);
insert into product values(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1);
insert into product values(6,'MILK','1L Toned Milk',3);
insert into product values(7,'BOAT Earphones','1.5 Meter long Dolby Atmos',4);
insert into product values(8,'Jeans','Strechable Denim Jeans with Various Size and Color ',5);
insert into product values(9,'Project IGI','compatible with windows 7 and above ',2);
insert into product values(10,'Hoodie','Black GUCCI for 13 Years and above ',5);
insert into product values(11,'Rich Dad Poor Dad ','Writteb by Robert Kiyosaki',1);
insert into product values(12,'Train Your Brain','By Shireen Stephen',1);

use Ecommerce;
insert into supplier_pricing values(1,1500,1,2);
insert into supplier_pricing values(2,30000,3,5);
insert into supplier_pricing values(3,3000,5,1);
insert into supplier_pricing values(4,2500,2,3);
insert into supplier_pricing values(5,1000,4,1);

insert into ordertable values(101,1500,'2021-10-06',2,1);
insert into ordertable values(102,1000,'2021-10-12',3,5);
insert into ordertable values(103,30000,'2021-09-16',5,2);
insert into ordertable values(104,1500,'2021-10-05',1,1);
insert into ordertable values(105,3000,'2021-08-16',4,3);
insert into ordertable values(106,1450,'2021-08-18',1,9);
insert into ordertable values(107,789,'2021-09-01',3,7);
insert into ordertable values(108,780,'2021-09-07',5,6);
insert into ordertable values(109,3000,'2021-00-10',5,3);
insert into ordertable values(110,2500,'2021-09-10',2,4);
insert into ordertable values(111,1000,'2021-09-15',4,5);
insert into ordertable values(112,789,'2021-09-16',4,7);
insert into ordertable values(113,31000,'2021-09-16',1,8);
insert into ordertable values(114,1000,'2021-09-16',3,5);
insert into ordertable values(115,3000,'2021-09-16',5,3);
insert into ordertable values(116,99,'2021-09-17',2,14);


insert into rating values(1,101,4);
insert into rating values(2,102,3);
insert into rating values(3,103,1);
insert into rating values(4,104,2);
insert into rating values(5,105,4);
insert into rating values(6,106,3);
insert into rating values(7,107,4);
insert into rating values(8,108,4);
insert into rating values(9,109,3);
insert into rating values(10,110,5);
insert into rating values(11,111,3);
insert into rating values(12,112,4);
insert into rating values(13,113,2);
insert into rating values(14,114,1);
insert into rating values(15,115,1);
insert into rating values(16,116,0);

-- 3.
select count(CUS_ID) from customer where CUS_ID = any (select CUS_ID from ordertable where ORD_AMOUNT >=3000) AND CUS_GENDER='F';
select count(CUS_ID) from customer where CUS_ID = any (select CUS_ID from ordertable where ORD_AMOUNT >=3000) AND CUS_GENDER='M';
-- 4. 
select ordertable.ORD_ID , product.PRO_NAME from ordertable inner join supplier_pricing ON ordertable.PRICING_ID = supplier_pricing.PRICING_ID inner join product on product.PRO_ID =supplier_pricing.PRO_ID WHERE ordertable.CUS_ID =2 ; 

-- 5.
select supplier.SUPP_ID  ,supplier.SUPP_NAME from supplier inner join supplier_pricing on supplier.SUPP_ID  = supplier_pricing.SUPP_ID inner join ordertable on supplier_pricing.PRICING_ID = ordertable.PRICING_ID ;

-- 6.
select category.CAT_ID as category_id ,category.CAT_NAME  ,product.PRO_NAME ,supplier_pricing.SUPP_PRICE from category inner join product on category.CAT_ID = product.CAT_ID inner join supplier_pricing on product.PRO_ID = supplier_pricing.PRO_ID where SUPP_PRICE=(SELECT MAX(SUPP_PRICE) 
FROM supplier_pricing);
-- 7.
select distinct product.PRO_ID , product.PRO_NAME from ordertable inner join supplier_pricing ON ordertable.PRICING_ID = supplier_pricing.PRICING_ID inner join product on product.PRO_ID =supplier_pricing.PRO_ID  where ordertable.ORD_DATE > 2021-10-05 ; 

-- 8.
select CUS_NAME from customer where CUS_NAME Like 'A%' or  CUS_NAME like '%A';

-- 9. 
SELECT supplier.SUPP_ID, supplier.SUPP_NAME,rating.RAT_RATSTARS,
CASE
    WHEN RAT_RATSTARS =5  THEN 'EXCELLENT'
    WHEN RAT_RATSTARS >4  THEN 'GOOD SERVICE'
    WHEN RAT_RATSTARS >2 THEN 'AVG SERVICE'
    ELSE 'POOR SERVICE'
END AS TYPE_OF_SERVICE
FROM supplier join rating ;


