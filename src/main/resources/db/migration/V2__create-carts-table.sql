create table carts
(
    id           uuid default gen_random_uuid() not null
        constraint carts_pk
            primary key,
    date_created date default current_date      not null
);

create table cart_items
(
    id         integer generated always as identity
        constraint cart_items_pk
            primary key,
    card_id    uuid    not null
        constraint cart__fk
            references carts (id),
    product_id integer not null
        constraint product_fk
            references products,
    quantity   integer default 1,
    constraint cart_product__unique
        unique (card_id, product_id),
    constraint quantity__positive
        check (cart_items.quantity > 0)
);

