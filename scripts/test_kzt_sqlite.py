import sqlite3
import os
import tempfile

db = os.path.join(tempfile.gettempdir(), "test_kzt.db")
if os.path.exists(db):
    os.remove(db)
conn = sqlite3.connect(db)
conn.execute(
    "CREATE TABLE cfg_configurationcurrency ("
    "Oid char(36) NOT NULL, Disabled bit, Ord numeric, Code numeric, "
    "Designation nvarchar(100), Acronym nvarchar(100), Symbol nvarchar(10), "
    "Entity nvarchar(512), ExchangeRate money, primary key (Oid))"
)
conn.execute("CREATE UNIQUE INDEX iCode ON cfg_configurationcurrency(Code)")
conn.execute("CREATE UNIQUE INDEX iDesignation ON cfg_configurationcurrency(Designation)")
sql = (
    "INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity) "
    "SELECT '3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b', 5, 5, 'KZT', 520.0000, "
    "'Казахстанский тенге', '₸', 'Казахстан' "
    "WHERE NOT EXISTS (SELECT 1 FROM cfg_configurationcurrency WHERE Acronym = 'KZT');"
)
conn.execute(sql)
conn.commit()
print(conn.execute("select Acronym, Designation, Code from cfg_configurationcurrency").fetchall())
