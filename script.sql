create table users
(
    id       integer generated always as identity primary key,
    name     varchar(255) not null,
    email    varchar(255) not null,
    password varchar(255) not null
);

create table addresses
(
    id      integer generated always as identity  primary key,
    street  varchar(255) not null,
    city    varchar(255) not null,
    zipcode varchar(255) not null,
    user_id integer       not null,
    constraint addresses_users_id_fk foreign key (user_id) references users (id)
);


