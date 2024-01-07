PRAGMA trusted_schema=1;

SELECT vfswritefile('test.txt', 'Hello World!'); -- expected: 12
SELECT vfsreadfile('test.txt'); -- expected: Hello World!

CREATE TABLE test (path TEXT);
INSERT INTO test VALUES ('test.txt');

CREATE VIEW test_view AS SELECT path, CAST(vfsreadfile(path) AS TEXT) AS content FROM test;
SELECT * FROM test_view; -- expected: test.txt|Hello World!
