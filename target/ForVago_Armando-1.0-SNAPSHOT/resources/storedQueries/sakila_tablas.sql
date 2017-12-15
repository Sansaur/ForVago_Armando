use sakila;

SET foreign_key_checks = 0;

drop table IF exists users_groups;
drop table IF exists users;
drop table IF exists groups;

create table users (
	user_id smallint primary key
    , user_name varchar(50) not null
    , password varchar(256) not null
);
alter table users add constraint AK_users_username unique(user_name);  

create table groups
(
   group_id int primary key auto_increment
   , group_name varchar(50) not null
   , description varchar(300)
);
alter table groups add constraint AK_groups_groupname unique(group_name);
       
create table users_groups
(
  group_id int not null,
  user_name varchar(50) not null
);
alter table users_groups add primary key (group_id, user_name);

alter table users_groups add constraint FK_usersgroups_users foreign key (user_name) references users(user_name);

alter table users_groups add constraint FK_usersgroups_groups foreign key (group_id) references groups(group_id);

insert into users (user_id, user_name, password) 
select customer_id, substring_index(email, '@', 1), sha2('temporal', 256) from customer;

insert into groups (group_name, description) values ('sysops', 'Grupo de administradores');
insert into groups (group_name, description) values ('staff', 'Personal de la tienda');
insert into groups (group_name, description) values ('customers', 'Grupo de clientes');

insert into users_groups (group_id, user_name) values (1, 'MARY.SMITH');
insert into users_groups (group_id, user_name) values (1, 'LUIS.YANEZ');
insert into users_groups (group_id, user_name) values (2, 'LUIS.YANEZ');
insert into users_groups (group_id, user_name) values (2, 'MIKE.WAY');
insert into users_groups (group_id, user_name) values (3, 'TONY.CARRANZA');
insert into users_groups (group_id, user_name) values (3, 'SARA.PERRY');

create view membership as
select ug.user_name, ug.group_id, g.group_name from
groups g inner join users_groups ug on g.group_id=ug.group_id
inner join users u on ug.user_name=u.user_name