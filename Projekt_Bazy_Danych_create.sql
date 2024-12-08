-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-12-08 11:06:22.501

-- tables
-- Table: activities
CREATE TABLE activities (
    activity_id int  NOT NULL,
    name nvarchar  NOT NULL,
    description text  NULL,
    CONSTRAINT unique_name UNIQUE (name),
    CONSTRAINT activities_pk PRIMARY KEY  (activity_id)
);

-- Table: advance_payments
CREATE TABLE advance_payments (
    id int  NOT NULL,
    value money  NOT NULL DEFAULT 0,
    date date  NOT NULL,
    CONSTRAINT nonnegative_value CHECK ([value] > 0),
    CONSTRAINT advance_payments_pk PRIMARY KEY  (id)
);

-- Table: classrooms
CREATE TABLE classrooms (
    classroom_id int  NOT NULL,
    capacity int  NOT NULL,
    name nvarchar  NOT NULL,
    CONSTRAINT classrooms_pk PRIMARY KEY  (classroom_id)
);

-- Table: course_modules
CREATE TABLE course_modules (
    activity_id int  NOT NULL,
    course_id int  NOT NULL,
    CONSTRAINT course_modules_pk PRIMARY KEY  (activity_id)
);

-- Table: courses
CREATE TABLE courses (
    activity_id int  NOT NULL,
    planner_id int  NOT NULL,
    CONSTRAINT courses_pk PRIMARY KEY  (activity_id)
);

-- Table: internships
CREATE TABLE internships (
    meeting_id int  NOT NULL,
    CONSTRAINT internships_pk PRIMARY KEY  (meeting_id)
);

-- Table: languages
CREATE TABLE languages (
    language_id int  NOT NULL,
    name nvarchar  NOT NULL,
    CONSTRAINT languages_pk PRIMARY KEY  (language_id)
);

-- Table: meeting_precense_make_up
CREATE TABLE meeting_precense_make_up (
    meeting_id int  NOT NULL,
    student_id int  NOT NULL,
    activity_id int  NOT NULL,
    CONSTRAINT meeting_precense_make_up_pk PRIMARY KEY  (meeting_id,student_id)
);

-- Table: meeting_presence
CREATE TABLE meeting_presence (
    meeting_id int  NOT NULL,
    student_id int  NOT NULL,
    CONSTRAINT meeting_presence_pk PRIMARY KEY  (meeting_id,student_id)
);

-- Table: meeting_schedule
CREATE TABLE meeting_schedule (
    meeting_id int  NOT NULL,
    start datetime  NOT NULL,
    "end" datetime  NOT NULL,
    CONSTRAINT meeting_schedule_pk PRIMARY KEY  (meeting_id)
);

-- Table: meeting_translators
CREATE TABLE meeting_translators (
    translator_id int  NOT NULL,
    meeting_id int  NOT NULL,
    langueage_id int  NOT NULL,
    CONSTRAINT meeting_translators_pk PRIMARY KEY  (translator_id)
);

-- Table: meetings
CREATE TABLE meetings (
    activity_id int  NOT NULL,
    tutor_id int  NOT NULL,
    CONSTRAINT meetings_pk PRIMARY KEY  (activity_id)
);

-- Table: module_meetings
CREATE TABLE module_meetings (
    module_id int  NOT NULL,
    meeting_id int  NOT NULL,
    CONSTRAINT module_meetings_pk PRIMARY KEY  (module_id)
);

-- Table: on_site_meetings
CREATE TABLE on_site_meetings (
    meeting_id int  NOT NULL,
    classroom_id int  NOT NULL,
    CONSTRAINT on_site_meetings_pk PRIMARY KEY  (meeting_id)
);

-- Table: online_asynchronus_meetings
CREATE TABLE online_asynchronus_meetings (
    meeting_id int  NOT NULL,
    video_url nvarchar  NOT NULL,
    CONSTRAINT online_asynchronus_meetings_pk PRIMARY KEY  (meeting_id)
);

-- Table: online_synchronus_meetins
CREATE TABLE online_synchronus_meetins (
    meeting_id int  NOT NULL,
    platform_id int  NOT NULL,
    video_url nvarchar  NULL,
    meeting_url nvarchar  NULL,
    CONSTRAINT online_synchronus_meetins_pk PRIMARY KEY  (meeting_id)
);

-- Table: orders
CREATE TABLE orders (
    order_id int  NOT NULL,
    product_id int  NOT NULL,
    students_id int  NOT NULL,
    order_date date  NOT NULL DEFAULT GETDATE(),
    payment_url nvarchar  NOT NULL,
    price money  NOT NULL DEFAULT 0,
    status nvarchar  NOT NULL,
    CONSTRAINT unique_link UNIQUE (payment_url),
    CONSTRAINT nonnegative_price CHECK ([price] >= 0),
    CONSTRAINT order_id PRIMARY KEY  (order_id)
);

-- Table: planners
CREATE TABLE planners (
    user_id int  NOT NULL,
    active bit  NOT NULL DEFAULT 1,
    CONSTRAINT planners_pk PRIMARY KEY  (user_id)
);

-- Table: platforms
CREATE TABLE platforms (
    platform_id int  NOT NULL,
    name nvarchar  NOT NULL,
    CONSTRAINT platforms_pk PRIMARY KEY  (platform_id)
);

-- Table: products
CREATE TABLE products (
    product_id int  NOT NULL,
    price money  NOT NULL DEFAULT 0,
    active bit  NOT NULL DEFAULT 1,
    CONSTRAINT nonnegative_price CHECK ([price] >= 0),
    CONSTRAINT products_pk PRIMARY KEY  (product_id)
);

-- Table: shopping_cart
CREATE TABLE shopping_cart (
    student_id int  NOT NULL,
    product_id int  NOT NULL,
    CONSTRAINT shopping_cart_pk PRIMARY KEY  (student_id,product_id)
);

-- Table: students
CREATE TABLE students (
    user_id int  NOT NULL,
    active bit  NOT NULL,
    country nvarchar  NOT NULL,
    city nvarchar  NOT NULL,
    street nvarchar  NOT NULL,
    zip_code nvarchar  NOT NULL,
    CONSTRAINT valid_zip_code CHECK (ISNUMERIC([zipcode]) = 1),
    CONSTRAINT students_pk PRIMARY KEY  (user_id)
);

-- Table: studies
CREATE TABLE studies (
    activity_id int  NOT NULL,
    planner_id int  NOT NULL,
    CONSTRAINT studies_pk PRIMARY KEY  (activity_id)
);

-- Table: studies_meetings
CREATE TABLE studies_meetings (
    meeting_id int  NOT NULL,
    module_id int  NOT NULL,
    CONSTRAINT studies_meetings_pk PRIMARY KEY  (meeting_id)
);

-- Table: studies_modules
CREATE TABLE studies_modules (
    activity_id int  NOT NULL,
    study_id int  NOT NULL,
    no_of_spots int  NULL DEFAULT NULL,
    CONSTRAINT vaild_no_of_spots CHECK ([no_of_spots] IS NULL OR [no_of_spots] > 0),
    CONSTRAINT studies_modules_pk PRIMARY KEY  (activity_id)
);

-- Table: translators
CREATE TABLE translators (
    user_id int  NOT NULL,
    active bit  NOT NULL DEFAULT 1,
    CONSTRAINT translator_id PRIMARY KEY  (user_id)
);

-- Table: translators_languages
CREATE TABLE translators_languages (
    translator_id int  NOT NULL,
    language_id int  NOT NULL,
    CONSTRAINT translators_languages_pk PRIMARY KEY  (translator_id)
);

-- Table: tutors
CREATE TABLE tutors (
    user_id int  NOT NULL,
    active bit  NOT NULL DEFAULT 1,
    CONSTRAINT tutors_pk PRIMARY KEY  (user_id)
);

-- Table: users
CREATE TABLE users (
    user_id int  NOT NULL,
    first_name nvarchar  NOT NULL,
    last_name nvarchar  NOT NULL,
    email nvarchar  NULL DEFAULT NULL,
    phone int  NULL DEFAULT NULL,
    CONSTRAINT unique_email UNIQUE (email),
    CONSTRAINT valid_email CHECK ([email] IS NULL OR [email] LIKE '_%@_%._%'),
    CONSTRAINT valid_phone CHECK ([phone] IS NULL OR ISNUMERIC([phone]) = 1 OR LEFT([phone], 1) = '+' AND ISNUMERIC(SUBSTRING([phone], 2, LEN([phone]))) = 1),
    CONSTRAINT users_pk PRIMARY KEY  (user_id)
);

-- foreign keys
-- Reference: Orders_students (table: orders)
ALTER TABLE orders ADD CONSTRAINT Orders_students
    FOREIGN KEY (students_id)
    REFERENCES students (user_id);

-- Reference: Planner_users (table: planners)
ALTER TABLE planners ADD CONSTRAINT Planner_users
    FOREIGN KEY (user_id)
    REFERENCES users (user_id);

-- Reference: Table_15_activities (table: meeting_precense_make_up)
ALTER TABLE meeting_precense_make_up ADD CONSTRAINT Table_15_activities
    FOREIGN KEY (activity_id)
    REFERENCES activities (activity_id);

-- Reference: Table_15_meeting_presence (table: meeting_precense_make_up)
ALTER TABLE meeting_precense_make_up ADD CONSTRAINT Table_15_meeting_presence
    FOREIGN KEY (meeting_id,student_id)
    REFERENCES meeting_presence (meeting_id,student_id);

-- Reference: course_modules_activities (table: course_modules)
ALTER TABLE course_modules ADD CONSTRAINT course_modules_activities
    FOREIGN KEY (activity_id)
    REFERENCES activities (activity_id);

-- Reference: course_modules_courses (table: course_modules)
ALTER TABLE course_modules ADD CONSTRAINT course_modules_courses
    FOREIGN KEY (course_id)
    REFERENCES courses (activity_id);

-- Reference: courses_Planner (table: courses)
ALTER TABLE courses ADD CONSTRAINT courses_Planner
    FOREIGN KEY (planner_id)
    REFERENCES planners (user_id);

-- Reference: courses_activities (table: courses)
ALTER TABLE courses ADD CONSTRAINT courses_activities
    FOREIGN KEY (activity_id)
    REFERENCES activities (activity_id);

-- Reference: internships_meetings (table: internships)
ALTER TABLE internships ADD CONSTRAINT internships_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: meeting_presence_meetings (table: meeting_presence)
ALTER TABLE meeting_presence ADD CONSTRAINT meeting_presence_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: meeting_presence_students (table: meeting_presence)
ALTER TABLE meeting_presence ADD CONSTRAINT meeting_presence_students
    FOREIGN KEY (student_id)
    REFERENCES students (user_id);

-- Reference: meeting_schedule_meetings (table: meeting_schedule)
ALTER TABLE meeting_schedule ADD CONSTRAINT meeting_schedule_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: meeting_translators_languages (table: meeting_translators)
ALTER TABLE meeting_translators ADD CONSTRAINT meeting_translators_languages
    FOREIGN KEY (langueage_id)
    REFERENCES languages (language_id);

-- Reference: meeting_translators_meetings (table: meeting_translators)
ALTER TABLE meeting_translators ADD CONSTRAINT meeting_translators_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: meeting_translators_translators (table: meeting_translators)
ALTER TABLE meeting_translators ADD CONSTRAINT meeting_translators_translators
    FOREIGN KEY (translator_id)
    REFERENCES translators (user_id);

-- Reference: meetings_activities (table: meetings)
ALTER TABLE meetings ADD CONSTRAINT meetings_activities
    FOREIGN KEY (activity_id)
    REFERENCES activities (activity_id);

-- Reference: meetings_tutors (table: meetings)
ALTER TABLE meetings ADD CONSTRAINT meetings_tutors
    FOREIGN KEY (tutor_id)
    REFERENCES tutors (user_id);

-- Reference: module_meetings_course_modules (table: module_meetings)
ALTER TABLE module_meetings ADD CONSTRAINT module_meetings_course_modules
    FOREIGN KEY (module_id)
    REFERENCES course_modules (activity_id);

-- Reference: module_meetings_meetings (table: module_meetings)
ALTER TABLE module_meetings ADD CONSTRAINT module_meetings_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: on_site_meetings_classrooms (table: on_site_meetings)
ALTER TABLE on_site_meetings ADD CONSTRAINT on_site_meetings_classrooms
    FOREIGN KEY (classroom_id)
    REFERENCES classrooms (classroom_id);

-- Reference: on_site_meetings_meetings (table: on_site_meetings)
ALTER TABLE on_site_meetings ADD CONSTRAINT on_site_meetings_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: online_asynchronus_meetings_meetings (table: online_asynchronus_meetings)
ALTER TABLE online_asynchronus_meetings ADD CONSTRAINT online_asynchronus_meetings_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: online_synchronus_meetins_meetings (table: online_synchronus_meetins)
ALTER TABLE online_synchronus_meetins ADD CONSTRAINT online_synchronus_meetins_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: online_synchronus_meetins_platforms (table: online_synchronus_meetins)
ALTER TABLE online_synchronus_meetins ADD CONSTRAINT online_synchronus_meetins_platforms
    FOREIGN KEY (platform_id)
    REFERENCES platforms (platform_id);

-- Reference: orders_products (table: orders)
ALTER TABLE orders ADD CONSTRAINT orders_products
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

-- Reference: shopping_cart_products (table: shopping_cart)
ALTER TABLE shopping_cart ADD CONSTRAINT shopping_cart_products
    FOREIGN KEY (product_id)
    REFERENCES products (product_id);

-- Reference: shopping_cart_students (table: shopping_cart)
ALTER TABLE shopping_cart ADD CONSTRAINT shopping_cart_students
    FOREIGN KEY (student_id)
    REFERENCES students (user_id);

-- Reference: student_users (table: students)
ALTER TABLE students ADD CONSTRAINT student_users
    FOREIGN KEY (user_id)
    REFERENCES users (user_id);

-- Reference: studies_Planner (table: studies)
ALTER TABLE studies ADD CONSTRAINT studies_Planner
    FOREIGN KEY (planner_id)
    REFERENCES planners (user_id);

-- Reference: studies_activities (table: studies)
ALTER TABLE studies ADD CONSTRAINT studies_activities
    FOREIGN KEY (activity_id)
    REFERENCES activities (activity_id);

-- Reference: studies_meetings_meetings (table: studies_meetings)
ALTER TABLE studies_meetings ADD CONSTRAINT studies_meetings_meetings
    FOREIGN KEY (meeting_id)
    REFERENCES meetings (activity_id);

-- Reference: studies_meetings_studies_modules (table: studies_meetings)
ALTER TABLE studies_meetings ADD CONSTRAINT studies_meetings_studies_modules
    FOREIGN KEY (module_id)
    REFERENCES studies_modules (activity_id);

-- Reference: studies_modules_activities (table: studies_modules)
ALTER TABLE studies_modules ADD CONSTRAINT studies_modules_activities
    FOREIGN KEY (activity_id)
    REFERENCES activities (activity_id);

-- Reference: studies_modules_studies (table: studies_modules)
ALTER TABLE studies_modules ADD CONSTRAINT studies_modules_studies
    FOREIGN KEY (study_id)
    REFERENCES studies (activity_id);

-- Reference: translators_languages_languages (table: translators_languages)
ALTER TABLE translators_languages ADD CONSTRAINT translators_languages_languages
    FOREIGN KEY (language_id)
    REFERENCES languages (language_id);

-- Reference: translators_languages_translators (table: translators_languages)
ALTER TABLE translators_languages ADD CONSTRAINT translators_languages_translators
    FOREIGN KEY (translator_id)
    REFERENCES translators (user_id);

-- Reference: translators_users (table: translators)
ALTER TABLE translators ADD CONSTRAINT translators_users
    FOREIGN KEY (user_id)
    REFERENCES users (user_id);

-- Reference: tutor_users (table: tutors)
ALTER TABLE tutors ADD CONSTRAINT tutor_users
    FOREIGN KEY (user_id)
    REFERENCES users (user_id);

-- End of file.

