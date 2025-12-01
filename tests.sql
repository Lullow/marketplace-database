-- INSERTS & READ QUERIES
-- run setup.sql before running this file.

-----------------------------------------------------------------------

-- Run this first:

-- INSERT USERS
INSERT INTO users (username, email, password_hash, location)
VALUES
    ('noobslayer', 'noobslayer@example.com', 'hashed_pw_1', 'Stockholm'),
    ('gitgood', 'gitgood@example.com', 'hashed_pw_2', 'Göteborg'),
    ('dwarfkidnapper', 'dwarfkidnapper@example.com', 'hashed_pw_3', 'Malmö'),
    ('snellhestpofirmafest', 'snellhestpofirmafest@example.com', 'hashed_pw_4', 'Uppsala'),
    ('chucknorris', 'chucknorris@example.com', 'hashed_pw_5', 'Stockholm');

-- Sanity check:
SELECT * FROM users;


-----------------------------------------------------------------------


-- Run this after:

-- Top-level categories.
INSERT INTO categories (name, description)
VALUES
    ('Datorer', 'Alla typer av stationära och bärbara datorer.'),
    ('Komponenter', 'Delar till datorbyggen.'),
    ('Kringutrustning', 'Tillbehör som mus, tangentbord, skärmar.'),
    ('Hemelektronik', 'Elektronik för hemmet.'),
    ('Mjukvara', 'Programvara och spel.'),
    ('Övrigt', 'Annat som inte passar i andra kategorier.');

-- Subcategories for datorer (computers).
INSERT INTO categories (name, description, parent_category_id)
VALUES
    ('Stationära datorer', 'Färdigbyggda eller hembyggda stationära datorer för gaming eller arbete.', 1),
    ('Bärbara datorer', 'Laptops för gaming och arbete.', 1);

-- Subcategories for komponenter (components).
INSERT INTO categories (name, description, parent_category_id)
VALUES
    ('Processorer', 'CPU:er för datorer.', 2),
    ('Kylning', 'Luft och vattenkylning.', 2),
    ('Moderkort', 'Moderkort till stationära datorer och workstations.', 2),
    ('Grafikkort', 'GPU:er till stationära datorer och workstations.', 2),
    ('Primärminne', 'RAM-minnen för datorer.', 2),
    ('Lagringsenheter', 'SSD / HDD.', 2),
    ('Nätaggregat', 'PSU, strömförsörjning.', 2),
    ('Chassi', 'Datorchassin.', 2);

-- Subcategories for kringutrustning (peripheral).
INSERT INTO categories (name, description, parent_category_id)
VALUES
    ('Skärmar', 'Datorskärmar.', 3),
    ('Mus & tangentbord', 'Tillbehör för datorer.', 3),
    ('Nätverksutrustning', 'Routrar, switchar, accesspunkter, m.m.', 3),
    ('Datortillbehör', 'Kablar, adaptrar m.m.', 3),
    ('VR-headset', 'Virtual reality-utrustning.', 3);

-- Subcategories for hemelektronik (home electronics).
INSERT INTO categories (name, description, parent_category_id)
VALUES
    ('Smarta hem', 'Smart home-utrustning.', 4),
    ('Spelkonsoler', 'PlayStation, Xbox, Nintendo.', 4),
    ('Mobiltelefoner', 'Smartphones.', 4),
    ('Surfplattor', 'Tablets.', 4),
    ('TV-apparater', 'TV och skärmar.', 4),
    ('Foto', 'Kameror, webbkameror och utrustning.', 4),
    ('Ljud', 'Högtalare och hörlurar.', 4);

-- Subcategories for mjukvara (software).
INSERT INTO categories (name, description, parent_category_id)
VALUES
    ('Spel & film', 'Spel och filmer.', 5),
    ('Övrig mjukvara', 'Program och licenser.', 5);

-- Subcategories for övrigt (miscellaneous).
INSERT INTO categories (name, description, parent_category_id)
VALUES
    ('Garderobrensning', 'Allmän försäljning av elektronik och prylar.', 6);

-- Sanity check:
SELECT id, name, parent_category_id FROM categories;


-----------------------------------------------------------------------


-- INSERT LISTINGS

-- user_id refers to users (1-5).
-- category_id refers to the subcategories.
INSERT INTO listings(
    user_id,
    category_id,
    title,
    description,
    price,
    currency,
    status,
    location,
    listing_type
)


VALUES
    -- Grafikkort (kategori: Grafikkort, id 12)
    (1, 12,
    'Nvidia RTX 4070 Ti',
    'Säljer mitt RTX 4070 Ti, endast använt i hemmabygge. Originalkartong finns, ej mining.',
    8500.00, 'SEK', 'active', 'Stockholm', 'sell'),

    -- Skärm (kategori: Skärmar, id 17)
    (2, 17,
    '27\" 1440p 144Hz IPS-skärm',
    'Fin gaming-skärm, 27 tum, 1440p, 144Hz, IPS-panel. Inga döda pixlar.',
    2600.00, 'SEK', 'active', 'Göteborg', 'sell'),

    -- Processor (kategori: Processorer, id 9)
    (3, 9,
    'AMD Ryzen 7 5800X',
    'Ryzen 7 5800X, använd i ca 1 år. Aldrig överklockad. Kylaren ingår ej.',
    1800.00, 'SEK', 'active', 'Malmö', 'sell'),

    -- Nätverksutrustning (kategori: Nätverksutrustning, id 19)
    (1, 19,
    'Ubiquiti UniFi AC Pro accesspunkter, 2-pack',
    'Två stycken UniFi AC Pro, fungerat perfekt i villa. Säljes pga uppgradering.',
    1900.00, 'SEK', 'active', 'Stockholm', 'sell'),

    -- Spelkonsol (kategori: Spelkonsoler, id 23)
    (4, 23,
    'PlayStation 5 Digital Edition',
    'PS5 Digital, köpt 2023. En handkontroll, strömkabel och HDMI ingår.',
    4500.00, 'SEK', 'active', 'Uppsala', 'sell'),

    -- Garderobrensning (kategori: Garderobrensning, id 31)
    (5, 31,
    'Låda med blandad datorhårdvara',
    'Blandad låda med gamla delar: kablar, fläktar, äldre grafikkort etc. Säljes i befintligt skick.',
    300.00, 'SEK', 'active', 'Stockholm', 'sell'),

    -- Köpesannons (listing_type = ''buy'')
    (4, 12,
    'Köpes: RTX 3080 eller 3090',
    'Söker ett RTX 3080 eller 3090 i bra skick, kvitto och kartong är ett plus.',
    0.00, 'SEK', 'active', 'Uppsala', 'buy');


-- Sanity check:
SELECT id, title, user_id, category_id FROM listings; 


-----------------------------------------------------------------------


-- INSERT LISTING COMMENTS
INSERT INTO listing_comments (listing_id, user_id, content)
VALUES
    -- Kommentarer på RTX 4070 Ti-annonsen (listing_id = 1)
    (1, 2, 'Är du första ägare? Finns kvitto kvar?'),
    (1, 4, 'Skulle du kunna gå ner till 8000 kr?'),

    -- Kommentar på skärmen (listing_id = 2)
    (2, 1, 'Har skärmen några repor eller ghosting?'),

    -- Kommentar på Ryzen-processorn (listing_id = 3)
    (3, 5, 'Passar den här i ett B550-moderkort?'),

    -- Kommentar på PS5 (listing_id = 5)
    (5, 3, 'Kan du tänka dig att mötas upp i Stockholm?');

-- Sanity check:
SELECT * FROM listing_comments;


-----------------------------------------------------------------------


-- INSERT LISTING LIKES
INSERT INTO listing_likes (user_id, listing_id)
VALUES
    -- Likes på RTX 4070 Ti (listing_id = 1)
    (2, 1),
    (3, 1),
    (5, 1),

    -- Likes på skärmen (listing_id = 2)
    (1, 2),
    (4, 2),

    -- Likes på Ryzen-processorn (listing_id = 3)
    (5, 3),

    -- Likes på PS5 (listing_id = 5)
    (1, 5),
    (2, 5),

    -- Likes på blandlådan (listing_id = 6)
    (3, 6);


-- Sanity check:
SELECT * FROM listing_likes;


-----------------------------------------------------------------------


-- INSERT DEALS
INSERT INTO deals (
    listing_id,
    buyer_id,
    seller_id,
    agreed_price,
    status,
    completed_at
)
VALUES
    -- Deal för RTX 4070 Ti (listing_id = 1), säljare: user 1, köpare: user 4
    (1, 4, 1, 8300.00, 'completed', NOW()),

    -- Deal för skärmen (listing_id = 2), säljare: user 2, köpare: user 5
    (2, 5, 2, 2500.00, 'completed', NOW()),

    -- Deal för PS5 (listing_id = 5), säljare: user 4, köpare: user 2
    (5, 2, 4, 4400.00, 'completed', NOW()),

    -- Pågående deal för lådan med blandad hårdvara (listing_id = 6), säljare: user 5, köpare: user 3
    (6, 3, 5, 250.00, 'pending', NULL);


-- Sanity check:
SELECT * FROM deals;


-----------------------------------------------------------------------


-- INSERT REVIEWS
INSERT INTO reviews (
    deal_id,
    reviewer_id,
    reviewee_id,
    rating,
    comment
)
VALUES
    -- Review for deal 1 (RTX 4070 Ti)
    -- Buyer (user 4) reviews seller (user 1)
    (1, 4, 1, 5, 'Snabb affär och mycket trevlig säljare!'),

    -- Review for deal 2 (Skärmen)
    -- Buyer (user 5) reviews seller (user 2)
    (2, 5, 2, 4, 'Varan i bra skick, bra kommunikation.'),

    -- Review for deal 3 (PS5)
    -- Buyer (user 2) reviews seller (user 4)
    (3, 2, 4, 5, 'Allt perfekt, rekommenderas!');

	-- Deal 4 har ingen review eftersom den är pågående (pending)


-- Sanity check:
SELECT * FROM reviews;


-----------------------------------------------------------------------


-- INSERT MESSAGES
INSERT INTO messages (
    sender_id,
    receiver_id,
    listing_id,
    content,
    read_at
)
VALUES
    -- Frågor om RTX 4070 Ti (listing_id = 1)
    (2, 1, 1, 'Hej! Är du först ägaren till kortet?', NULL),
    (1, 2, 1, 'Yes, först ägare och kvitto finns kvar.', NOW()),

    -- PM om skärmen (listing_id = 2)
    (5, 2, 2, 'Hej! Kan du gå ner till 2400 kr?', NULL),
    (2, 5, 2, 'Tyvärr, 2500 är mitt lägsta.', NULL),

    -- Generellt meddelande, ingen listing (NULL)
    (3, 4, NULL, 'Tja! Har du fler delar till salu?', NULL),
    (4, 3, NULL, 'Tjena! Yes, kolla min profil.', NOW());


-- Sanity check:
SELECT * FROM messages;


-----------------------------------------------------------------------


-- DEL 3:

-- READ QUERIES

-- Query all listings.
SELECT 
    l.id,
    l.title,
    l.price,
    l.status,
    l.created_at,
    u.username AS seller,
    c.name AS category
FROM listings l
JOIN users u ON l.user_id = u.id
JOIN categories c ON l.category_id = c.id
ORDER BY l.id;

-----------------------------------------------------------------------

-- Top 10 latest listings (based on created_at).
SELECT 
    l.id,
    l.title,
    l.price,
    l.status,
    l.created_at,
    u.username AS seller,
    c.name AS category
FROM listings l
JOIN users u ON l.user_id = u.id
JOIN categories c ON l.category_id = c.id
ORDER BY l.created_at DESC
LIMIT 10;

-----------------------------------------------------------------------

-- Get a specific user by username.
SELECT
    id,
    username,
    email,
    location,
    created_at,
    market_rating
FROM users
WHERE username = 'gitgood';

-----------------------------------------------------------------------

-- Get all comments written by a specific user.
SELECT
    lc.id AS comment_id,
    u.username AS commenter,
    l.title AS listing_title,
    lc.content,
    lc.created_at
FROM listing_comments lc
JOIN users u ON lc.user_id = u.id
JOIN listings l ON lc.listing_id = l.id
WHERE u.username = 'snellhestpofirmafest'
ORDER BY lc.created_at DESC;

-----------------------------------------------------------------------

-- Get all reviews with deal, reviewer and reviewee info.
SELECT
    r.id AS review_id,
    d.id AS deal_id,
    l.title AS listing_title,
    reviewer.username AS reviewer,
    reviewee.username AS reviewee,
    r.rating,
    r.comment,
    r.created_at
FROM reviews r
JOIN deals d ON r.deal_id = d.id
JOIN listings l ON d.listing_id = l.id
JOIN users reviewer ON r.reviewer_id = reviewer.id
JOIN users reviewee ON r.reviewee_id = reviewee.id
ORDER BY r.created_at DESC;

-----------------------------------------------------------------------

-- JOIN-QUERY:

-- JOIN example: All messages between two users (3 and 4).
SELECT
    m.id AS message_id,
    sender.username AS sender,
    receiver.username AS receiver,
    m.content,
    m.created_at,
    m.read_at
FROM messages m
JOIN users sender ON m.sender_id = sender.id
JOIN users receiver ON m.receiver_id = receiver.id
WHERE (m.sender_id = 3 AND m.receiver_id = 4)
OR (m.sender_id = 4 AND m.receiver_id = 3)
ORDER BY m.created_at;

-----------------------------------------------------------------------

-- JOIN example: Number of likes per listing.
SELECT
    l.id AS listing_id,
    l.title,
    COUNT(ll.id) AS like_count
FROM listings l
LEFT JOIN listing_likes ll ON l.id = ll.listing_id
GROUP BY l.id, l.title
ORDER BY like_count DESC;

-----------------------------------------------------------------------

-- OPTIONAL QUERIES: 

-- 1. All listings in a specific location.
SELECT id, title, price, location
FROM listings
WHERE location = 'Stockholm';

-----------------------------------------------------------------------

-- 2. Listings by a specific user.
SELECT id, title, price
FROM listings
WHERE user_id = 1;

-----------------------------------------------------------------------

-- 3. Comments on a specific listing.
SELECT
    lc.id,
    u.username,
    lc.content,
    lc.created_at
FROM listing_comments lc
JOIN users u ON lc.user_id = u.id
WHERE lc.listing_id = 1;

-----------------------------------------------------------------------

-- 4. Unread messages for a user.
SELECT
    m.id,
    sender.username AS sender,
    m.content,
    m.created_at
FROM messages m
JOIN users sender ON m.sender_id = sender.id
WHERE m.receiver_id = 4
AND m.read_at IS NULL;

-----------------------------------------------------------------------

-- 5. Number of listings per category.
SELECT
    c.name,
    COUNT(l.id) AS listing_count
FROM categories c
LEFT JOIN listings l ON l.category_id = c.id
GROUP BY c.name
ORDER BY listing_count DESC;

-----------------------------------------------------------------------

-- 6. Completed deals with buyer/seller info.
SELECT
    d.id AS deal_id,
    l.title,
    buyer.username AS buyer,
    seller.username AS seller,
    d.agreed_price,
    d.completed_at
FROM deals d
JOIN listings l ON d.listing_id = l.id
JOIN users buyer ON d.buyer_id = buyer.id
JOIN users seller ON d.seller_id = seller.id
WHERE d.status = 'completed'
ORDER BY d.completed_at DESC;

-----------------------------------------------------------------------

-- 7. Most active commenters.
SELECT
    u.username,
    COUNT(lc.id) AS comment_count
FROM users u
LEFT JOIN listing_comments lc ON lc.user_id = u.id
GROUP BY u.username
ORDER BY comment_count DESC;

-----------------------------------------------------------------------

-- 8. All buy listings.
SELECT id, title, description
FROM listings
WHERE listing_type = 'buy';