PRAGMA trusted_schema=1;

SELECT vfswritefile('test.txt', 'Hello World!'); -- expected: 12
SELECT vfsreadfile('test.txt'); -- expected: Hello World!

CREATE TABLE test (path TEXT NOT NULL PRIMARY KEY);
INSERT INTO test VALUES ('test.txt');

CREATE VIEW test_view AS SELECT path, CAST(vfsreadfile(path) AS TEXT) AS content FROM test;
SELECT * FROM test_view; -- expected: test.txt|Hello World!

INSERT INTO test VALUES ('test2.txt');
SELECT * FROM test_view WHERE path='test.txt'; -- expected: test.txt|Hello World!
SELECT * FROM test_view WHERE path='test2.txt'; -- expected: test2.txt|
