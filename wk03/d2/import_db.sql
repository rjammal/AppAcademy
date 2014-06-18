
CREATE TABLE users (
  id INTEGER PRIMARY KEY, 
  fname VARCHAR(255) NOT NULL, 
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY, 
  title VARCHAR(255), 
  body TEXT, 
  author_id INTEGER,  
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY, 
  question_id INTEGER NOT NULL, 
  follower_id INTEGER NOT NULL, 
  
  FOREIGN KEY (question_id) REFERENCES questions(id), 
  FOREIGN KEY (follower_id) REFERENCES users(id) 
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY, 
  subject_question_id INTEGER NOT NULL, 
  parent_reply_id INTEGER, 
  author_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (subject_question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id), 
  FOREIGN KEY (author_id) REFERENCES users(id)

);


CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY, 
  user_id INTEGER NOT NULL, 
  question_id INTEGER NOT NULL, 
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

insert into users (fname, lname) values ('Rosemary', 'Jammal');
insert into users (fname, lname) values ('Marco', 'Arduini');
insert into users (fname, lname) values ('Andrew', 'Richards');
insert into questions (title, body, author_id) values (
  'Why does it keep tabbing?',
  'I hate this text editor!',
  2
);
insert into questions (title, body, author_id) values (
  "What's a good question?",
  "I would like to know a good question to ask!",
  1
);
insert into question_followers (question_id, follower_id) values (
 1,
 1 
);
insert into replies (subject_question_id, parent_reply_id, author_id, body) values (
  1,
  null,
  2,
  'A fake reply to a meaningless question.'
);
insert into replies (subject_question_id, parent_reply_id, author_id, body) values (
  1,
  null,
  2,
  'Another fake reply to a meaningless question.'
);
insert into replies (subject_question_id, parent_reply_id, author_id, body) values (
  1,
  2,
  1,
  "Rosemary's reply."
);

insert into question_likes (user_id, question_id) values (
  3,
  2
);
