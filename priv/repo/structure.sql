CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" INTEGER PRIMARY KEY, "inserted_at" TEXT);
CREATE TABLE IF NOT EXISTS "jokes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "name" TEXT, "text" TEXT, "inserted_at" TEXT NOT NULL, "updated_at" TEXT NOT NULL, "nsfk" INTEGER DEFAULT false);
CREATE TABLE sqlite_sequence(name,seq);
INSERT INTO schema_migrations VALUES(20231017024616,'2023-10-17T02:47:35');
INSERT INTO schema_migrations VALUES(20231021161939,'2023-10-21T17:09:22');
