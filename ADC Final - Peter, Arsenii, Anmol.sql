SET DEFINE OFF;

DROP TABLE users;
DROP TABLE user_profile;
DROP TABLE posts;
DROP TABLE categories;
DROP TABLE comments;
DROP TABLE replies;

CREATE TABLE users (
    u_user_id NUMBER PRIMARY KEY,
    u_first_name VARCHAR2(32),
    u_last_name VARCHAR2 (32),
    u_password_hash VARCHAR2(64),
    u_created_at DATE,
    u_updated_at DATE
);
INSERT INTO users
    VALUES (1, 'Peter', 'Nguyen', 'Hkntl3MNFQwIZXFp', DATE '2024-02-19', DATE '2025-01-30');
INSERT INTO users
    VALUES (2, 'Snow', 'Birmingham', 'zV9D8qICxdwX8smr', DATE '2024-03-01', DATE '2025-01-12');
INSERT INTO users
    VALUES (3, 'Hanna', 'Nguyen', '6KkFbiO530fCoqxV', DATE '2025-02-11', DATE '2025-02-26');

CREATE TABLE user_profile (
    up_user_profile_id NUMBER PRIMARY KEY,
    up_user_id NUMBER,
    CONSTRAINT fk_up_userid FOREIGN KEY (up_user_id)
        REFERENCES users(u_user_id)
        ON DELETE CASCADE,
    up_user_name VARCHAR2(32),
    up_city VARCHAR2 (24),
    up_country VARCHAR2 (32),
    up_profile_link VARCHAR2 (128)
);
INSERT INTO user_profile 
    VALUES (1, 1, 'peternguyen1999', 'Ho Chi Minh', 'Vietnam', 'https://adc.net/user/peter-nguyen-hochi-1999');
INSERT INTO user_profile 
    VALUES (2, 2, 'snobirm2025', 'Scaborough', 'Canada', 'https://adc.net/user/snow-birmi-scabo-2025');
INSERT INTO user_profile 
    VALUES (3, 3, 'hannanguyen', 'Ha Noi', 'Vietnam', 'https://adc.net/user/hanna-nguyen-hanoi-2000');

CREATE TABLE posts (
    p_post_id NUMBER PRIMARY KEY,
    p_user_profile_id NUMBER,
    CONSTRAINT fk_p_upid FOREIGN KEY (p_user_profile_id)
        REFERENCES user_profile(up_user_profile_id)
        ON DELETE CASCADE,
    p_user_id NUMBER,
    CONSTRAINT fk_p_userid FOREIGN KEY (p_user_id)
        REFERENCES users(u_user_id)
        ON DELETE CASCADE,
    p_title VARCHAR2 (80),
    p_content VARCHAR2 (2000),
    p_date_created DATE
);
INSERT INTO posts
    VALUES (1, 1, 1, 'Health & Diet - What''s actually good?', 'Lorem ipsum dolor sit amet,
    consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
    occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', DATE '2024-07-11');
INSERT INTO posts
    VALUES (2, 1, 1, 'Health & Diet - A journey''s worth', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco
    laboris nisi ut aliquip ex ea commodo consequat.
    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
    occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', DATE '2024-09-20');
INSERT INTO posts
    VALUES (3, 3, 3, 'Vampire Masquerade - Bloodline', 'Lorem ipsum dolor sit amet,
    consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
    occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', DATE '2025-04-13');
    
CREATE TABLE categories (
    cat_category_id NUMBER PRIMARY KEY,
    cat_name VARCHAR2 (16),
    cat_description VARCHAR2 (150)
);
INSERT INTO categories
    VALUES (1, 'Comedy', 'Humorous, witty, playful, entertaining, and relatable.');
INSERT INTO categories
    VALUES (2, 'Horror', 'Chilling, terrifying, suspenseful, dark, eerie, macabre, unsettling, gruesome, haunting, ominous.');
INSERT INTO categories
    VALUES (3, 'Romance', 'Passionate, emotional, intimate, heartfelt, tender, yearning, affectionate, dreamy, enchanting, soulful.');

CREATE TABLE comments (
    c_comment_id NUMBER PRIMARY KEY,
    c_user_profile_id NUMBER,
    CONSTRAINT fk_c_upid FOREIGN KEY (c_user_profile_id)
        REFERENCES user_profile(up_user_profile_id)
        ON DELETE CASCADE,
    c_post_id NUMBER,
    CONSTRAINT fk_c_poid FOREIGN KEY (c_post_id)
        REFERENCES posts(p_post_id)
        ON DELETE CASCADE,
    c_content VARCHAR2 (150),
    c_created_at DATE
);
INSERT INTO comments
    VALUES (1, 2, 1, 'those are terrible suggestions!', DATE '2024-07-12');
INSERT INTO comments
    VALUES (2, 2, 2, 'again with these bad health tips, you should retire!', DATE '2024-09-22');
INSERT INTO comments
    VALUES (3, 2, 3, 'I love vampey wifey!', DATE '2025-04-14');

CREATE TABLE replies (
    rep_reply_id NUMBER PRIMARY KEY,
    rep_post_id NUMBER,
    CONSTRAINT fk_rep_poid FOREIGN KEY (rep_post_id)
        REFERENCES posts(p_post_id)
        ON DELETE CASCADE,
    rep_user_profile_id NUMBER,
    CONSTRAINT fk_rep_upid FOREIGN KEY (rep_user_profile_id)
        REFERENCES user_profile(up_user_profile_id)
        ON DELETE CASCADE,
    rep_content VARCHAR2 (150),
    rep_created_at DATE
);
INSERT INTO replies
    VALUES (1, 3, 3, 'Right??!!', DATE '2025-04-13');
INSERT INTO replies
    VALUES (2, 3, 3, 'Right??!!', DATE '2025-04-13');
INSERT INTO replies
    VALUES (3, 3, 3, 'Sorry, I made a duplicate and I don''t know how to remove it.', DATE '2025-04-13');
    
COMMIT;