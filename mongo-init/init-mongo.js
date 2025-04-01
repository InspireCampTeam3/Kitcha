db = db.getSiblingDB("admin");
if (db.getUser("kitcha") === null) {
  db.createUser({
    user: "kitcha",
    pwd: "password",
    roles: [ { role: "root", db: "admin" } ]
  });
}

db = db.getSiblingDB("board_db");
if (db.getUser("kitcha") === null) {
  db.createUser({
    user: "kitcha",
    pwd: "password",
    roles: [ { role: "readWrite", db: "board_db" } ]
  });
}
