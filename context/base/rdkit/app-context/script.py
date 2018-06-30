from rdkit import Chem
import psycopg2
import pprint

m = Chem.MolFromSmiles('Cc1ccccc1')
print(m)

conn_string = "host='db' dbname='chembience' user='chembience' password='Arg0'"
conn = psycopg2.connect(conn_string)
cursor = conn.cursor()

# rdkit extension installed?
cursor.execute("select * from pg_extension")
extensions = cursor.fetchall()
pprint.pprint(extensions)