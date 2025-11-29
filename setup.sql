-- USERS
CREATE TABLE users(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique for every user.
    username VARCHAR(50) UNIQUE NOT NULL, -- UNIQUE used to make sure that's there's only one user with that username. NOT NULL used to make sure that a username is avaliable for loggin and communication with others.
    email VARCHAR(255) UNIQUE NOT NULL,   -- UNIQUE used to make sure that there's only one user with that email adress (one mail per user). NOT NULL used to create account, have contact information and eventuall password recovery possibilty.
    password_hash TEXT NOT NULL,  -- NOT NULL so user is obligated to use a password to loggin to their account.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOT NULL and DEFAULT is used so there's a timestamp that shows when the account is created, default is set so the current time of the creation is the timestamp. 
    market_rating NUMERIC(2, 1) CHECK (market_rating BETWEEN 1 AND 5), -- NULL allowed first, rating must be 1–5 if present and 2, 1 is used to allow one decimal. e.g. "3.5" rating. 
    location VARCHAR(100), -- No constraints because user isn't obligated to post location.
    is_active BOOLEAN NOT NULL DEFAULT TRUE -- NOT NULL and DEFAULT user will be active until their deactivate the account.
);


-- CATEGORIES
CREATE TABLE categories(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - uniqe id for every category.
    name VARCHAR(100) NOT NULL, -- NOT NULL so the category always has a name (to make the marketplace more userfriendly).
    description TEXT, -- User is not obligated to write a description of the item, therefor there's no constraints.
    parent_category_id BIGINT REFERENCES categories(id), -- FK, self-referencing relationship (instead of creating additional table).
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP -- DEFAULT sets a automatic timestamp when the category was created.
);


-- LISTINGS
CREATE TABLE listings(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique id for every listing.
    user_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, every listing must have a user.
    category_id BIGINT NOT NULL REFERENCES categories(id), -- NOT NULL and FK, every category must belong to a listing.
    title VARCHAR(150) NOT NULL, -- NOT NULL, every listing needs to have a title.
    description TEXT NOT NULL, -- NOT NULL, every listing needs to have a description so other users knows what the user is selling/buying/trading.
    price NUMERIC(10, 2) NOT NULL, -- NOT NULL, a price is obligatory.
    currency CHAR(3) NOT NULL DEFAULT 'SEK', -- NOT NULL and DEFAULT, the currency is obligatory abd the standard is set to 'SEK'.
    status VARCHAR(20) NOT NULL DEFAULT 'active', -- NOT NULL and DEFAULT, the listing needs a status, the standard is set to active.
    location VARCHAR(100), -- No constraints so users don't need to enter their location.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOT NULL and DEFAULT, all listings must have a created date.
    updated_at TIMESTAMPTZ, -- No constraints, not all listings will be updated. 
    views_count INT NOT NULL DEFAULT 0, -- NOT NULL and DEFAULT, all listings will have a view count that is set to zero when created.
    listing_type VARCHAR(20) NOT NULL DEFAULT 'sell' -- NOT NULL and DEFAULT, all listings will have a standard listing type of "want to sell" as default when created.
);


-- LISTING COMMENTS
CREATE TABLE listing_comments(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique id for every comment.
    listing_id BIGINT NOT NULL REFERENCES listings(id), -- NOT NULL and FK, comments must be connected to a specific listing.
    user_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, comments must be made by a user.
    content TEXT NOT NULL, -- NOT NULL, a comment must contain some form of content.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOT NULL and DEFAULT, a timestamp is set automatically when the comment is made.
    updated_at TIMESTAMPTZ, -- No constraints, a comment might not be updated.
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE -- NOT NULL and DEFAULT, used for "soft delete", standard is that the comment is "active".
);


-- LISTING IMAGES
CREATE TABLE listing_images(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique id for every image.
    listing_id BIGINT NOT NULL REFERENCES listings(id), -- NOT NULL and FK, each image belongs to a listing.
    image_url TEXT NOT NULL, -- NOT NULL, so we know where the image is located.
    position SMALLINT NOT NULL DEFAULT 1, -- NOT NULL and DEFAULT, used to sort images, standard is set to 1.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP -- NOT NULL and DEFAULT, time of creation is set automatically.
);


-- LISTING LIKES (junction table)
CREATE TABLE listing_likes(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique id for every "like".
    user_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, there must be a user that likes the listing.
    listing_id BIGINT NOT NULL REFERENCES listings(id), -- NOT NULL and FK, there must be a listing that the user can like.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOT NULL and DEFAULT, automatically set timestamp when the like was set.
    CONSTRAINT unique_user_listing_like UNIQUE (user_id, listing_id) -- UNIQUE, prevents the same user from liking the same listing more than once. ---------------------   UNSURE OF THIS TYPE OF CONSTRAINT ----------------------
);


-- DEALS
CREATE TABLE deals(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique id for every deal.
    listing_id BIGINT NOT NULL REFERENCES listings(id), -- NOT NULL and FK, each deal is made by a specific listing.
    buyer_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, the deal must have a buyer (user).
    seller_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, the deal must have a seller (user).
    agreed_price NUMERIC(10, 2) NOT NULL, -- NOT NULL, there must be a price thats been agreed upon.
    status VARCHAR(20) NOT NULL DEFAULT 'pending', -- NOT NULL and DEFAULT, status is needed for following the "flow", starts as 'pending'.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOT NULL and DEFAULT, when the deal was created.
    completed_at TIMESTAMPTZ -- Can be NULL so the value is empty when the deal is created, and only gets a timestamp once the deal is completed.
);


-- REVIEWS
CREATE TABLE reviews(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique id for every review.
    deal_id BIGINT NOT NULL REFERENCES deals(id), -- NOT NULL and FK, a review can be set only when a deal is made.
    reviewer_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, the review must have a user that made it.
    reviewee_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, the review must have a user thats been reviewed.
    rating SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- NOT NULL and CHECK, the review must be between 1 and 5.
    comment TEXT, -- No constraints, a comment is optional.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP -- NOT NULL and DEFAULT, the review gets the current timestamp when set.
);


-- MESSAGES
CREATE TABLE messages(
    id BIGSERIAL PRIMARY KEY, -- PRIMARY KEY - unique id for every message.
    sender_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, every message must have a user.
    receiver_id BIGINT NOT NULL REFERENCES users(id), -- NOT NULL and FK, every message must have a reciever.
    listing_id BIGINT REFERENCES listings(id), -- FK (nullable), the message can be connected to a listing, but it's not requiered.
    content TEXT NOT NULL, -- NOT NULL, cannot be an empty message.
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOT NULL and DEFAULT, the message gets the current timestamp when it's sent.
    read_at TIMESTAMPTZ -- Set to NULL, timestamp is only set when the receiver opens the message.
);