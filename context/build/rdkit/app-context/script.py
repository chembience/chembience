from rdkit import Chem, __version__
import psycopg2
import pprint
import time

print(__version__)

m = Chem.MolFromSmiles('Cc1ccccc1')
print(m)

time.sleep(30)

conn_string = "host='db' dbname='chembience' user='chembience' password='Chembience0'"
conn = psycopg2.connect(conn_string)
cursor = conn.cursor()

# rdkit extension installed?
cursor.execute("select * from pg_extension")
extensions = cursor.fetchall()
pprint.pprint(extensions)
