db = db.getSiblingDB("board_db");

db.createUser({
  user: "kitcha",
  pwd: "password",
  roles: [{ role: "readWrite", db: "board_db" }]
});
