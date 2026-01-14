CREATE TABLE users
(
    id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name     VARCHAR(255) NOT NULL,
    email    VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE addresses
(
    id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    street  VARCHAR(255) NOT NULL,
    city    VARCHAR(255) NOT NULL,
    state   VARCHAR(255) NOT NULL,
    zip     VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    CONSTRAINT addresses_users_id_fk
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE NO ACTION
);

CREATE INDEX addresses_users_id_fk ON addresses (user_id);

CREATE TABLE categories
(
    id   SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE products
(
    id            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    price         DECIMAL(10, 2) NOT NULL,
    description   TEXT NOT NULL,
    category_id   SMALLINT,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
            REFERENCES categories (id)
            ON DELETE NO ACTION
);

CREATE INDEX fk_category ON products (category_id);

CREATE TABLE profiles
(
    id             INTEGER PRIMARY KEY,
    bio            TEXT,
    phone_number   VARCHAR(15),
    date_of_birth  DATE,
    loyalty_points INTEGER DEFAULT 0 CHECK (loyalty_points >= 0),
    CONSTRAINT profiles_users_id_fk
        FOREIGN KEY (id)
            REFERENCES users (id)
            ON DELETE NO ACTION
);

CREATE TABLE wishlist
(
    product_id INTEGER NOT NULL,
    user_id    INTEGER NOT NULL,
    PRIMARY KEY (product_id, user_id),
    CONSTRAINT fk_wishlist_on_product
        FOREIGN KEY (product_id)
            REFERENCES products (id)
            ON DELETE CASCADE,
    CONSTRAINT fk_wishlist_on_user
        FOREIGN KEY (user_id)
            REFERENCES users (id)
            ON DELETE NO ACTION
);

CREATE INDEX fk_wishlist_on_user ON wishlist (user_id);
